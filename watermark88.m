% 8*8�ֿ�ĵ�һ��ˮӡ������Ƕ��
% ����P����ӳ���8*8�ֿ�
% ����Q���ֿ�P��Ӧ��8*8ӳ���
% ���ֵQ1��Ƕ��ˮӡ��ķֿ�Q
% ˮӡ��Ϣ������Կkey1
function [Q1] = watermark88(P,Q)
Q=Q-mod(Q,8);  %ÿ���������������Чλ��0

%����ָ�ˮӡ��Ϣr   
P=P-mod(P,8);  %ÿ���������������Чλ��0
Fy=[16 11 10 16 24 40 51 61         %������
    12 12 14 19 26 58 60 55
    14 13 16 24 40 57 69 56
    14 17 22 29 51 87 80 62
    18 22 37 56 68 109 103 77
    24 35 55 64 81 104 113 92
    49 64 78 87 103 121 120 101
    72 92 95 98 112 100 103 99];
P1=dct2(P);
for i=1:8
    for j=1:8
        P2(i,j)=fix(P1(i,j)/Fy(i,j));
    end
end
r1 = complement(P2(1,1), 8);  %����64bit�Ļָ�ˮӡ��Ϣr
r2 = complement(P2(1,2), 8);
r3 = complement(P2(2,1), 8);
r4 = complement(P2(3,1), 8);
r5 = complement(P2(2,2), 8);
r6 = complement(P2(1,3), 8);
r7 = complement(P2(1,4), 8);
r8 = complement(P2(2,3), 8);

r=[r1;r2;r3;r4;r5;r6;r7;r8];

for i=1:8  %Ƕ��ָ�ˮӡ
    for j=1:8
        Q1(i,j)=Q(i,j)+r(i,j)*4;   
    end
end