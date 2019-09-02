clear
size1=1024;  %控制图片大小
q1=64;      %第一层水印嵌入强度  4的倍数最好
key1=13;    %分块映射位置密钥

PIC=imread('lena.jpg');
if ndims(PIC)==3
    PIC=rgb2gray(PIC);
end
PIC=imresize(PIC,[size1 size1]);
imwrite(PIC,'PIC.bmp','bmp');

[I,r22]=watermark_r1(PIC,q1);   %嵌入第一层水印
I=uint8(I);
[I1]=watermark_r2(I);  %嵌入第二层水印
[I2]=watermark_r3(I1,key1); %嵌入第三层水印
figure(1);
subplot(121),imshow(PIC);title('原图');
subplot(122),imshow(I2);title('含水印的图片');
imwrite(I2,'PIC_watermark.bmp','bmp');

%{
%认证水印提取
I3=imread('PIC_watermark.bmp');
[r11]=recovery_r1(I3,q1);
sign=sum(sum(abs(r22-r11)));
[M,N]=size(PIC);
PP=recovery_r1_show(r11,M,N);
figure(2),imshow(PP);
%}

%%%%%PSNR和NC计算%%%%%%
[M,N]=size(PIC);
MSE=sum(sum(abs(PIC-I2)))/(M*M);
PSNR=10*log10(255^2/MSE)