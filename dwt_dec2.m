%图像的三级小波分解 
function [LL2,LH2,HL2,HH2,LH1,HL1,HH1]=dwt_dec2(I)
[c,s]=wavedec2(double(I),2,'db1');
LL2=appcoef2(c,s,'db1',2);
[LH2,HL2,HH2] = detcoef2('all',c,s,2);
[LH1,HL1,HH1] = detcoef2('all',c,s,1);
