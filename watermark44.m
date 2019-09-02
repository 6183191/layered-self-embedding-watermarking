% 4*4�ֿ�ĵڶ���ˮӡ������Ƕ��
% ����P����ӳ���4*4�ֿ�
% ����Q���ֿ�P��Ӧ��4*4ӳ���
% ���ֵQ1��Ƕ��ˮӡ��ķֿ�Q
% ˮӡ��Ϣ������Կkey1
function [Q1] = watermark44(P,Q)
Q=Q-mod(Q,4);  %ÿ���������������Чλ��0
%��������۸ļ��{s,t}
B=sum(sum(Q))/16;%ƽ��ǿ��ֵ
Bj(1)=sum(sum(Q(1:2,1:2)))/4;
Bj(2)=sum(sum(Q(1:2,3:4)))/4;
Bj(3)=sum(sum(Q(3:4,1:2)))/4;
Bj(4)=sum(sum(Q(3:4,3:4)))/4;
for j=1:4        %ƽ��ǿ����Ϣt  4bit
    if(Bj(j)>B)
        t(j)=1;
    else
        t(j)=0;
    end
end
for j=1:4    %��żУ����Ϣs  4bit
    s(j)=sum(dec2bin(Bj(j))-'0');
    if mod(s(j),2)==0
        s(j)=0;
    else
        s(j)=1;
    end
end
%����ָ�ˮӡ��Ϣr   
P=P-mod(P,4);  %ÿ���������������Чλ��0
Fy=[8 6 6 8         %������
    2 6 7 7
    4 6 8 7
    7 5 4 5];
P1=dct2(P);
for i=1:4 
    for j=1:4
        P2(i,j)=fix(P1(i,j)/Fy(i,j));
    end
end
r1 = complement(P2(1,1), 8);  %ǰ����ϵ���Ĳ�������24bit�Ļָ�ˮӡ��Ϣr
r2 = complement(P2(1,2), 8);
r3 = complement(P2(2,1), 8);
r=[r1,r2,r3];

x=[1,1,3,3];
y=[1,3,1,3];

for i=1:4  %Ƕ����֤��Ϣ
    Q1(x(i),y(i))=Q(x(i),y(i))+s(i)*2+t(i);
end
for i=1:4  %Ƕ��ָ�ˮӡ
    Q1(x(i),y(i)+1)=Q(x(i),y(i)+1)+r(i*6-5)*2+r(i*6-4);
    Q1(x(i)+1,y(i))=Q(x(i)+1,y(i))+r(i*6-3)*2+r(i*6-2);
    Q1(x(i)+1,y(i)+1)=Q(x(i)+1,y(i)+1)+r(i*6-1)*2+r(i*6);
end

