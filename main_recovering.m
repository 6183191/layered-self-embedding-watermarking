clear;
q1=64;      %��һ��ˮӡǶ��ǿ��
key1=13;    %������ˮӡ�ֿ�ӳ��λ����Կ
Fy=[8 6 6 8         %4*4������
    2 6 7 7
    4 6 8 7
    7 5 4 5];
Fyy=[16 11 10 16 24 40 51 61         %8*8������
    12 12 14 19 26 58 60 55
    14 13 16 24 40 57 69 56
    14 17 22 29 51 87 80 62
    18 22 37 56 68 109 103 77
    24 35 55 64 81 104 113 92
    49 64 78 87 103 121 120 101
    72 92 95 98 112 100 103 99];


%%%%��ԭʼͼƬ�����޸�%%%%
attack_pic();         

PIC=imread('PIC_change.bmp');
if ndims(PIC)==3
    PIC=rgb2gray(PIC);
end
figure(1);subplot(142);imshow(PIC);title('�޸ĺ��ͼƬ');

[M,N]=size(PIC);
X2=mapping44(M,N,key1);%�ҵ�4*4�ֿ��ӳ��λ��
%%%%�ֲ�ͼ��������֤%%%%
[sign4]=recovery_authentication(PIC,X2);


%%%%%%%%%%%%%%%%%���ݻָ�%%%%%%%%%%%%%%
xx=[1,1,3,3];
yy=[1,3,1,3];
a1=PIC;
sign5=sign4;
%���б��ٻ��ֿ���Ϣ�ķֿ�δ���ٻ�����ȡ��������ˮӡ��Ϣ
for i=1:4:M
    for j=1:4:N
        if sign4(ceil(i/4),ceil(j/4))==1
            x=floor(X2(ceil(i/4),ceil(j/4))/(N/4));
            y=mod(X2(ceil(i/4),ceil(j/4)),N/4);
            if sign4(x+1,y+1)==0   
                %������ˮӡ�ָ���Ϣ
                R=PIC(4*x+1:4*x+4,4*y+1:4*y+4);
                for k=1:4    
                    rrr(k*6-4)=mod(R(xx(k),yy(k)+1),2);
                    rrr(k*6-5)=(mod(R(xx(k),yy(k)+1),4)-rrr(k*6-4))/2;
                    rrr(k*6-2)=mod(R(xx(k)+1,yy(k)),2);
                    rrr(k*6-3)=(mod(R(xx(k)+1,yy(k)),4)-rrr(k*6-2))/2;
                    rrr(k*6)=mod(R(xx(k)+1,yy(k)+1),2);
                    rrr(k*6-1)=(mod(R(xx(k)+1,yy(k)+1),4)-rrr(k*6))/2;
                end
                Q1=zeros(4,4);
                Q1(1,1)=typecast(uint8(bin2dec(num2str(rrr(1:8)))), 'int8');
                Q1(1,2)=typecast(uint8(bin2dec(num2str(rrr(9:16)))), 'int8');
                Q1(2,1)=typecast(uint8(bin2dec(num2str(rrr(17:24)))), 'int8');           
                for ii=1:4 
                    for jj=1:4
                        Q2(ii,jj)=Q1(ii,jj)*Fy(ii,jj);
                    end
                end
                Q2=idct2(Q2);
                a1(i:i+3,j:j+3)=Q2;
                sign5(ceil(i/4),ceil(j/4))=0;
            end
        end        
    end
end
%���б��ٻ��ֿ���Ϣ�ķֿ鱻�ٻ�
[r11]=recovery_r1(a1,q1);    %��һ��ˮӡ��ȡ
XX2=mapping88(M,N);
for i=1:4:M-4
    for j=1:4:N-4
        if sign5(ceil(i/4),ceil(j/4))==1
            x=floor(XX2(ceil(i/8),ceil(j/8))/(N/8));
            y=mod(XX2(ceil(i/8),ceil(j/8)),N/8);
            if (sign4(x*2+1,y*2+1)==0)&&(sign4(x*2+1,y*2+2)==0)&&(sign4(x*2+2,y*2+1)==0)&&(sign4(x*2+2,y*2+2)==0)                
                %�ڶ���ˮӡ�ָ���Ϣ
                R=PIC(8*x+1:8*x+8,8*y+1:8*y+8);
                for k=1:8
                    for l=1:8
                        rrrr(k,l)=(mod(R(k,l),8)-mod(R(k,l),4))/4;
                    end
                end
                Q1=zeros(8,8);
                Q1(1,1)=typecast(uint8(bin2dec(num2str(rrrr(1,:)))), 'int8');
                Q1(1,2)=typecast(uint8(bin2dec(num2str(rrrr(2,:)))), 'int8');
                Q1(2,1)=typecast(uint8(bin2dec(num2str(rrrr(3,:)))), 'int8'); 
                Q1(3,1)=typecast(uint8(bin2dec(num2str(rrrr(4,:)))), 'int8');
                Q1(2,2)=typecast(uint8(bin2dec(num2str(rrrr(5,:)))), 'int8');
                Q1(1,3)=typecast(uint8(bin2dec(num2str(rrrr(6,:)))), 'int8');
                Q1(1,4)=typecast(uint8(bin2dec(num2str(rrrr(7,:)))), 'int8');
                Q1(2,3)=typecast(uint8(bin2dec(num2str(rrrr(8,:)))), 'int8');
                for ii=1:8
                    for jj=1:8
                        Q2(ii,jj)=Q1(ii,jj)*Fyy(ii,jj);
                    end
                end
                Q2=idct2(Q2);
                if ceil(i/4)==ceil(i/8)
                    if(ceil(j/4)==ceil(j/8))
                        Q3=Q2(5:8,5:8);
                    else
                        Q3=Q2(5:8,1:4);
                    end
                else
                    if(ceil(j/4)==ceil(j/8))
                        Q3=Q2(1:4,5:8);
                    else
                        Q3=Q2(1:4,1:4);
                    end
                end
                a1(i:i+3,j:j+3)=Q3;
                sign5(ceil(i/4),ceil(j/4))=0;
            else
                %��һ��ˮӡ�ָ���Ϣ
                tempx1=ceil(i/4);
                tempx2=ceil(i/4);
                if ceil(i/4)>1
                    tempx1=ceil(i/4)-1;
                end
                if ceil(i/4)<M/4
                    tempx2=ceil(i/4)+1;
                end
                tempy1=ceil(j/4);
                tempy2=ceil(j/4);
                if ceil(j/4)>1
                    tempy1=ceil(j/4)-1;
                end
                if ceil(j/4)<N/4
                    tempy2=ceil(j/4)+1;
                end               
                signt=sum(sum(sign5(tempx1:tempx2,tempy1:tempy2)));    %��Χ�˿�����̶�
                if signt>=4           %��Χ�˿��������أ��õ�һ��ˮӡ�ָ�
                    Q1=zeros(8,8);
                    i1=i;
                    j1=j;
                    if mod(i,8)==5
                        i1=i-4;
                    end
                    if mod(j,8)==5
                        j1=j-4;
                    end
                    i1=(i1+7)/8;
                    j1=(j1+7)/8;
                    k=(i1*M/8+j1-M/8-1)*8+1;
                    r22=r11(k:k+7);
                    Q1(1,1)=typecast(uint8(bin2dec(num2str(r22))), 'int8');
                    for ii=1:8
                        for jj=1:8
                            Q2(ii,jj)=Q1(ii,jj)*Fyy(ii,jj);
                        end
                    end
                    Q2=idct2(Q2);
                    if ceil(i/4)==ceil(i/8)
                        if(ceil(j/4)==ceil(j/8))
                            Q3=Q2(5:8,5:8);
                        else
                            Q3=Q2(5:8,1:4);
                        end
                    else
                        if(ceil(j/4)==ceil(j/8))
                            Q3=Q2(1:4,5:8);
                        else
                            Q3=Q2(1:4,1:4);
                        end
                    end
                    a1(i:i+3,j:j+3)=Q3;
                    sign5(ceil(i/4),ceil(j/4))=0;
                end
            end            
        end
    end
end
%������İ˸��ֿ����ؿ�ľ�ֵ��Ϊ�ָ���Ϣ
for i=1:4:M-4
    for j=1:4:N-4
        if sign5(ceil(i/4),ceil(j/4))==1
            avg=0;count=0;
            if i>1
                if sign5(ceil(i/4)-1,ceil(j/4))==0
                    avg=avg+sum(sum(a1(i-4:i-1,j:j+3)));
                    count=count+1;
                end
                if j>1
                    if sign5(ceil(i/4)-1,ceil(j/4)-1)==0
                        avg=avg+sum(sum(a1(i-4:i-1,j-4:j-1)));
                        count=count+1;
                    end
                end
                if j<N
                    if sign5(ceil(i/4)-1,ceil(j/4)+1)==0
                        avg=avg+sum(sum(a1(i-4:i-1,j+4:j+7)));
                        count=count+1;
                    end
                end
            end
            if i<M
                if sign5(ceil(i/4)+1,ceil(j/4))==0
                    avg=avg+sum(sum(a1(i+4:i+7,j:j+3)));
                    count=count+1;
                end
                if j>1
                    if sign5(ceil(i/4)+1,ceil(j/4)-1)==0
                        avg=avg+sum(sum(a1(i+4:i+7,j-4:j-1)));
                        count=count+1;
                    end
                end
                if j<N
                    if sign5(ceil(i/4)+1,ceil(j/4)+1)==0
                        avg=avg+sum(sum(a1(i+4:i+7,j+4:j+7)));
                        count=count+1;
                    end
                end
            end
            if j>1
                if sign5(ceil(i/4),ceil(j/4)-1)==0
                    avg=avg+sum(sum(a1(i:i+3,j-4:j-1)));
                    count=count+1;
                end
            end
            if j<N
                if sign5(ceil(i/4),ceil(j/4)+1)==0
                    avg=avg+sum(sum(a1(i:i+3,j+4:j+7)));
                    count=count+1;
                end
            end
            count=count*16;
            avg=avg/count;
            a1(i:i+3,j:j+3)=avg;                
        end     
    end
end

figure(1);subplot(143);imshow(a1);title('�ָ����ͼƬ');
imwrite(a1,'PIC_recovery.bmp','bmp');

%��һ��ˮӡ����ȡ����������֤
PP=recovery_r1_show(r11,M,N);
figure(1);subplot(144);imshow(PP);title('��һ��ˮӡ��ȡ');
imwrite(PP,'PIC_authentication.bmp','bmp');


%%%%%PSNR��NC����%%%%%%
PIC11=imread('PIC_watermark.bmp'); %���뺬ˮӡ��ͼƬ
MSE=sum(sum(abs(PIC11-a1)))/(M*M);
PSNR=10*log10(255^2/MSE)
NC=nc(PIC11,a1)