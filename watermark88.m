% 8*8分块的第一层水印生成与嵌入
% 参数P：被映射的8*8分块
% 参数Q：分块P对应的8*8映射块
% 输出值Q1：嵌入水印后的分块Q
% 水印信息加密密钥key1
function [Q1] = watermark88(P,Q)
Q=Q-mod(Q,8);  %每个像素最低三个有效位置0

%计算恢复水印信息r   
P=P-mod(P,8);  %每个像素最低两个有效位置0
Fy=[16 11 10 16 24 40 51 61         %量化表
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
r1 = complement(P2(1,1), 8);  %生成64bit的恢复水印信息r
r2 = complement(P2(1,2), 8);
r3 = complement(P2(2,1), 8);
r4 = complement(P2(3,1), 8);
r5 = complement(P2(2,2), 8);
r6 = complement(P2(1,3), 8);
r7 = complement(P2(1,4), 8);
r8 = complement(P2(2,3), 8);

r=[r1;r2;r3;r4;r5;r6;r7;r8];

for i=1:8  %嵌入恢复水印
    for j=1:8
        Q1(i,j)=Q(i,j)+r(i,j)*4;   
    end
end