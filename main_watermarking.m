clear
size1=1024;  %����ͼƬ��С
q1=64;      %��һ��ˮӡǶ��ǿ��  4�ı������
key1=13;    %�ֿ�ӳ��λ����Կ

PIC=imread('lena.jpg');
if ndims(PIC)==3
    PIC=rgb2gray(PIC);
end
PIC=imresize(PIC,[size1 size1]);
imwrite(PIC,'PIC.bmp','bmp');

[I,r22]=watermark_r1(PIC,q1);   %Ƕ���һ��ˮӡ
I=uint8(I);
[I1]=watermark_r2(I);  %Ƕ��ڶ���ˮӡ
[I2]=watermark_r3(I1,key1); %Ƕ�������ˮӡ
figure(1);
subplot(121),imshow(PIC);title('ԭͼ');
subplot(122),imshow(I2);title('��ˮӡ��ͼƬ');
imwrite(I2,'PIC_watermark.bmp','bmp');

%{
%��֤ˮӡ��ȡ
I3=imread('PIC_watermark.bmp');
[r11]=recovery_r1(I3,q1);
sign=sum(sum(abs(r22-r11)));
[M,N]=size(PIC);
PP=recovery_r1_show(r11,M,N);
figure(2),imshow(PP);
%}

%%%%%PSNR��NC����%%%%%%
[M,N]=size(PIC);
MSE=sum(sum(abs(PIC-I2)))/(M*M);
PSNR=10*log10(255^2/MSE)