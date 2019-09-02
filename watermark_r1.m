%��һ��ˮӡ��������Ƕ��
%����С���任����ͼ���HL2��LH2Ƕ��ˮӡ
%IΪǶ���һ��ˮӡ���ͼƬ
%r88��dct�任��������zigzag˳���ǰ�˸�ϵ��ֵ��8λ������
%qΪǶ��ǿ��
function [I,r22]=watermark_r1(PIC,q)
[M,N]=size(PIC);
r1=zeros(8,M*N/64);  %��һ��ˮӡ
for i=1:M/8
    for j=1:N/8
        P=PIC(i*8-7:i*8,j*8-7:j*8);
        [r]=watermark_r1_dct88(P);
        r1(1:8,i*M/8+j-M/8)=complement(r,8);
    end
end
r11=r1(:)';
r22=r11;
[LL2,LH2,HL2,HH2,LH1,HL1,HH1]=dwt_dec2(PIC);
k=1;
for i=1:M/4
    for j=1:N/4
        %ǰ�벿��Ƕ��LH2
        temp=LH2(i,j);
        tempr=r11(k);
        if tempr==0
            if mod(temp,q)<=3*q/4 && mod(temp,q)>0
                temp=temp-mod(temp,q)+q/4;
            else if mod(temp,q)<q && mod(temp,q)>3*q/4
                    temp=temp-mod(temp,q)+5*q/4;
                end
            end
        end
        if tempr==1
            if mod(temp,q)<=q/4 && mod(temp,q)>0
                temp=temp-mod(temp,q)-q/4;
            else if mod(temp,q)<q && mod(temp,q)>q/4
                    temp=temp-mod(temp,q)+3*q/4;
                end
            end
        end
        LH2(i,j)=temp;
        %��벿��Ƕ��HL2
        temp=HL2(i,j);
        tempr=r11(M*N/16+k);
        if tempr==0
            if mod(temp,q)<=3*q/4 && mod(temp,q)>0
                temp=temp-mod(temp,q)+q/4;
            else if mod(temp,q)<q && mod(temp,q)>3*q/4
                    temp=temp-mod(temp,q)+5*q/4;
                end
            end
        end
        if tempr==1
            if mod(temp,q)<=q/4 && mod(temp,q)>0
                temp=temp-mod(temp,q)-q/4;
            else if mod(temp,q)<q && mod(temp,q)>q/4
                    temp=temp-mod(temp,q)+3*q/4;
                end
            end
        end
        HL2(i,j)=temp;
        k=k+1;
    end
end
LL1=dwt_rec1(LL2,LH2,HL2,HH2);
I=dwt_rec1(LL1,LH1,HL1,HH1);