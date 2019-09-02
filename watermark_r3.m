function [I]=watermark_r3(PIC,key1)
[M,N]=size(PIC);
X2=mapping44(M,N,key1);%找到4*4分块的映射位置

%嵌入4*4水印
I=PIC;
for i=1:4:M
    for j=1:4:N
        x=floor(X2(ceil(i/4),ceil(j/4))/(N/4));
        y=mod(X2(ceil(i/4),ceil(j/4)),N/4);
        P=PIC(i:i+3,j:j+3);
        Q=PIC(4*x+1:4*x+4,4*y+1:4*y+4);
        Q1=watermark44(P,Q);
        I(4*x+1:4*x+4,4*y+1:4*y+4)=Q1;
    end
end