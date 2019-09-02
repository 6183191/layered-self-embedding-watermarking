function [r11]=recovery_r1(I,q)
[M,N]=size(I);
[LL2,LH2,HL2,HH2,LH1,HL1,HH1]=dwt_dec2(I);
k=1;
tempr=0;
for i=1:M/4
    for j=1:N/4
        temp=LH2(i,j);
        if mod(temp,q)<=q/2 && mod(temp,q)>0
            tempr=0;
        else if mod(temp,q)>q/2 && mod(temp,q)<q
                tempr=1;
            end
        end
        r11(k)=tempr;
        temp=HL2(i,j);
        if mod(temp,q)<=q/2 && mod(temp,q)>0
            tempr=0;
        else if mod(temp,q)>q/2 && mod(temp,q)<q
                tempr=1;
            end
        end
        r11(M*N/16+k)=tempr;
        k=k+1;
    end
end