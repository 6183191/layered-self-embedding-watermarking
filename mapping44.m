function  [X2]=mapping44(M,N,key1)
%ÕÒµ½4*4Ó³ÉäÎ»ÖÃ
count=0;
for i=1:N/4
    for j=1:N/4
        X(i,j)=count;
        count=count+1;
    end
end
V=M*N/16;
X1=mod(X*key1,V)+1;
q=mod(X1,N/4);
for i=1:N/4
    for j=1:N/4
        if q(i,j)>N/8
            q(i,j)=q(i,j)-N/8;
        else
            q(i,j)=q(i,j)+N/8;
        end
        if X1(i,j)==V
            X1(i,j)=0;
        end
        X2(i,q(i,j))=X1(i,j);
    end
end