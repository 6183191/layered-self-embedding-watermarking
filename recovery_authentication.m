function [sign4]=recovery_authentication(PIC1,X2)
%分层图像内容认证
Fy=[8 6 6 8         %4*4量化表
    2 6 7 7
    4 6 8 7
    7 5 4 5];
[M,N]=size(PIC1);

for i=1:4:M
    for j=1:4:N
        Q=PIC1(i:i+3,j:j+3);
        %第一层检测
        signtemp=recovery_authentication_firstcheck(Q);          
        sign1(floor(i/2)+1,floor(j/2)+1)=signtemp(1);
        sign1(floor(i/2)+1,floor(j/2)+2)=signtemp(2);
        sign1(floor(i/2)+2,floor(j/2)+1)=signtemp(3);
        sign1(floor(i/2)+2,floor(j/2)+2)=signtemp(4);
        %第二层检测
        if sum(signtemp)>=1
            sign2(floor(i/4)+1,floor(j/4)+1)=1;
        else
            sign2(floor(i/4)+1,floor(j/4)+1)=0;
        end
    end
end

%第三层检测
sign3=sign2;
for i=2:M/4-1
    for j=2:N/4-1
        sum1=0;
        if sign2(i,j)==0
            sum1=sign2(i-1,j-1)+sign2(i-1,j)+sign2(i-1,j+1)+sign2(i,j-1)+sign2(i,j+1);
            sum1=sum1+sign2(i+1,j-1)+sign2(i+1,j)+sign2(i+1,j+1);
            if sum1>=5
                sign3(i,j)=1;
            end
        end
    end
end

%第四层检测
xx=[1,1,3,3];
yy=[1,3,1,3];
sign4=sign3;
for i=1:4:M
    for j=1:4:N
        if sign3(ceil(i/4),ceil(j/4))==0
            x=floor(X2(ceil(i/4),ceil(j/4))/(N/4));
            y=mod(X2(ceil(i/4),ceil(j/4)),N/4);
            if sign3(x+1,y+1)==0
                P3=PIC1(i:i+3,j:j+3);
                P=P3-mod(P3,4);  %每个像素最低三个有效位置0
                P1=dct2(P);
                for ii=1:4 
                    for jj=1:4
                        P2(ii,jj)=fix(P1(ii,jj)/Fy(ii,jj));
                    end
                end
                r=zeros(1,24);
                r1 = complement(P2(1,1), 8);  %前三个系数的补码生成24bit的恢复水印信息r
                r2 = complement(P2(1,2), 8);
                r3 = complement(P2(2,1), 8);
                r=[r1,r2,r3];
                
                R1=PIC1(4*x+1:4*x+4,4*y+1:4*y+4);
                for k=1:4
                    rr(k*6-4)=mod(R1(xx(k),yy(k)+1),2);
                    rr(k*6-5)=(mod(R1(xx(k),yy(k)+1),4)-rr(k*6-4))/2;
                    rr(k*6-2)=mod(R1(xx(k)+1,yy(k)),2);
                    rr(k*6-3)=(mod(R1(xx(k)+1,yy(k)),4)-rr(k*6-2))/2;
                    rr(k*6)=mod(R1(xx(k)+1,yy(k)+1),2);
                    rr(k*6-1)=(mod(R1(xx(k)+1,yy(k)+1),4)-rr(k*6))/2;
                end
                if rr~=r
                    sign4(ceil(i/4),ceil(j/4))=1;
                end
            end
        end        
    end
end
figure(2);
subplot(141);imshow(sign1);title('第一层检测结果');
subplot(142);imshow(sign2);title('第二层检测结果');
subplot(143);imshow(sign3);title('第三层检测结果');
subplot(144);imshow(sign4);title('第四层检测结果');