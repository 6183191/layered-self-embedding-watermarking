function [I]=recovery_r1_show(r11,M,N)
Fyy=[16 11 10 16 24 40 51 61         %8*8Á¿»¯±í
    12 12 14 19 26 58 60 55
    14 13 16 24 40 57 69 56
    14 17 22 29 51 87 80 62
    18 22 37 56 68 109 103 77
    24 35 55 64 81 104 113 92
    49 64 78 87 103 121 120 101
    72 92 95 98 112 100 103 99];
I=zeros(M,N);
Q2=zeros(8,8);
k=1;
for i=1:8:M
    for j=1:8:N
        Q1=zeros(8,8);
        Q1(1,1)=typecast(uint8(bin2dec(num2str(r11(k:k+7)))), 'int8');
        for ii=1:8
            for jj=1:8
                Q2(ii,jj)=Q1(ii,jj)*Fyy(ii,jj);
            end
        end
        Q2=idct2(Q2);
        I(i:i+7,j:j+7)=Q2;
        k=k+8;             
    end
end
I=uint8(I);