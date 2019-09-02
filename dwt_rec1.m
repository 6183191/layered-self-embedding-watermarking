%Ò»²ãÄæÐ¡²¨±ä»»
function I=dwt_rec1(LL1,LH1,HL1,HH1)
s=[size(LL1);size(LL1);size(LL1)*2];
LL1=LL1(:)';
LH1=LH1(:)';
HL1=HL1(:)';
HH1=HH1(:)';
c=[LL1 LH1 HL1 HH1];
I=waverec2(c,s,'db1');