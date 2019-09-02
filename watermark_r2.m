function [I]=watermark_r2(PIC)
[M,N]=size(PIC);
XX2=mapping88(M,N);

%Ç¶Èë8*8Ë®Ó¡
I=PIC;
for i=1:8:M
    for j=1:8:N
        x=floor(XX2(ceil(i/8),ceil(j/8))/(N/8));
        y=mod(XX2(ceil(i/8),ceil(j/8)),N/8);
        P=PIC(i:i+7,j:j+7);
        Q=PIC(8*x+1:8*x+8,8*y+1:8*y+8);
        Q1=watermark88(P,Q);
        I(8*x+1:8*x+8,8*y+1:8*y+8)=Q1;
    end
end