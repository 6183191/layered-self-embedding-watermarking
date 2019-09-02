%第一层检测 检验2*2分块内的认证水印
function [sign] = recovery_authentication_firstcheck(Q)
x=[1,1,3,3];
y=[1,3,1,3];

for j=1:4
    t(j)=mod(Q(x(j),y(j)),2);
    s(j)=(mod(Q(x(j),y(j)),4)-t(j))/2;
end
Q1=Q-mod(Q,4);  %每个像素最低三个有效位置0
B=sum(sum(Q1))/16;%平均强度值
Bj(1)=sum(sum(Q1(1:2,1:2)))/4;
Bj(2)=sum(sum(Q1(1:2,3:4)))/4;
Bj(3)=sum(sum(Q1(3:4,1:2)))/4;
Bj(4)=sum(sum(Q1(3:4,3:4)))/4;
for j=1:4        %平均强度信息t  4bit
    if(Bj(j)>B)
        t1(j)=1;
    else
        t1(j)=0;
    end
end
for j=1:4    %奇偶校验信息s  4bit
    s1(j)=sum(dec2bin(Bj(j))-'0');
    if mod(s1(j),2)==0
        s1(j)=0;
    else
        s1(j)=1;
    end
end
for i=1:4
    if (t1(i)==t(i))&&(s1(i)==s(i))
        sign(i)=0;
    else
        sign(i)=1;
    end
end
for i=1:4
    if sign(i)==0
        if sum(sum(Q(x(i):x(i)+1,y(i):y(i)+1)))==0
            Q(x(i):x(i)+1,y(i):y(i)+1)=1;
            sign(i)=1;
        end
    end
end
end