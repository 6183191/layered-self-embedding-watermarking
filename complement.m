% 用于计算十进制数的补码
% 参数x：原始十进制数组，正负数皆可
% 参数n：输出的二进制补码最小位数，如果位数不够会根据x的取值范围自动扩展
% 输出值c：转换得到的二进制补码字符串数组
function [c] = complement(x,n)
    for i = 1 : length(x)
        if x(i) < 0
            x(i) = x(i) + 2^n;
        end
    end
    c = dec2bin(x, n)-'0';
end