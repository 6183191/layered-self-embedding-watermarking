# layered-self-embedding-watermarking
毕设  
《分层自嵌入数字水印的内容认证与恢复算法》

为了保护图像数据的完整性、对图像进行认证和内容恢复，论文在分析数字水印研究现状和基本理论的基础上，提出一种分层自嵌入数字水印的内容认证和恢复算法。
论文的创新点在于算法在图像的变换域和空间域分层嵌入含有图像自身信息的恢复水印和认证水印，兼具了图片抵抗一定程度图像操作的鲁棒性要求和被篡改部位全盲检测的要求。同时，算法对图像进行分层篡改检测，准确检测出被篡改区域。除此之外，算法利用嵌入的水印，依据恢复精度分层恢复图像内容，极大地增加了图像内容的恢复能力，在图像遭受大面积篡改时也能达到较高的恢复效果。
实验结果表明，论文算法在抵抗剪切攻击和拼贴攻击方面有良好的表现，在剪切面积高达90%的情况下，对图像内容恢复程度能达到60%以上。同时，算法能抵抗JPEG压缩、加入噪声、中值滤波攻击，鲁棒性良好。



main_watermarking.m			嵌入数字水印主程序  
main_recovering.m  			图像内容恢复主程序  
attack_pic.m				对图像进行不同的攻击的函数  
complement.m				将十进制数转化为补码的函数  
dwt_dec2.m				二级小波分解函数  
dwt_rec1.m				一级逆小波变换函数  
mapping44.m				找到4*4分块的映射分块函数  
mapping88.m				找到8*8分块的映射分块函数  
nc.m					计算归一化相关系数值函数  
recovery_authentication.m		分层篡改检测函数  
recovery_authentication_firstcheck.m	第一层篡改检测函数  
recovery_r1.m				第一层水印信息提取函数  
recovery_r1_show.m			第一层水印信息复原成图像信息函数  
watermark_r1.m				嵌入第一层水印信息函数  
watermark_r1_dct88.m			得到8*8分块的第一个dct系数函数  
watermark_r2.m				嵌入第二层水印信息函数  
watermark_r3.m				嵌入第三层水印信息函数  
watermark44.m				4*4分块水印信息生成函数  
watermark88.m				8*8分块水印信息生成函数  

PIC.bmp					载体图片  
PIC_authentication.bmp			提取的第一层认证水印信息图片  
PIC_change.bmp				攻击后的图片  
PIC_recovery.bmp			内容恢复后的图片  
PIC_watermark.bmp			嵌入水印后的载体图片  
lena.jpg				载体图片彩图  
lake_dot.bmp				拼贴攻击中要进行拼贴的图片  
