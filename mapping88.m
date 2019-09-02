function  [XX2]=mapping88(M,N)
%’“µΩ8*8”≥…‰Œª÷√
count=0;
N1=M*N/64;
for i=1:N/8
    for j=1:N/8
        XX(i,j)=count;
        count=count+1;
    end
end
XX2(1:M/8/2,1:N/8/2)=XX(M/8/2+1:M/8,N/8/2+1:N/8);
XX2(M/8/2+1:M/8,N/8/2+1:N/8)=XX(1:M/8/2,1:N/8/2);
XX2(1:M/8/2,N/8/2+1:N/8)=XX(M/8/2+1:M/8,1:N/8/2);
XX2(M/8/2+1:M/8,1:N/8/2)=XX(1:M/8/2,N/8/2+1:N/8);