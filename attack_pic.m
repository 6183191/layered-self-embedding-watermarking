function attack_pic()
%¶ÔÍ¼Ïñ½øÐÐ²»Í¬¹¥»÷

PIC=imread('PIC_watermark.bmp'); %ÔØÈëº¬Ë®Ó¡µÄÍ¼Æ¬
if ndims(PIC)==3
    PIC=rgb2gray(PIC);
end
figure(1);subplot(141);imshow(PIC);title('Ô­Í¼');
[M,N]=size(PIC);

%{
%¼ôÇÐ¹¥»÷
PIC(1:M/2,1:N)=0;
%PIC(M/2+1:M,N/2+1:N)=0;
imwrite(PIC,'PIC_change.bmp','bmp');
%}

%Æ´Ìù¹¥»÷
size1=512;
b=imread('lake_dot.bmp');
b=imresize(b,[size1 size1]);
dotx=[500,300];
doty=[500,200];
PIC(dotx(1):dotx(1)+size1-1,doty(1):doty(1)+size1-1)=b;  
%PIC(dotx(2):dotx(2)+size1-1,doty(2):doty(2)+size1-1)=b;
imwrite(PIC,'PIC_change.bmp','bmp');
%}
%{
%jpegÑ¹Ëõ
imwrite(PIC, 'PIC_change.jpg','jpg','quality',40)  
%}
%{
%½·ÑÎÔêÉù¹¥»÷
PIC=imnoise(PIC,'salt & pepper',0.01);
imwrite(PIC,'PIC_change.bmp','bmp');
%}
%{
%ÖÐÖµÂË²¨¹¥»÷
PIC=medfilt2(PIC);                   
imwrite(PIC,'PIC_change.bmp','bmp');
%}
