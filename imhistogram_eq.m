function  output_histogramEq  = imhistogram_eq(img)

%  -Inputs- 
%	img: original grayscale image (uint8)
%
%  -Outputs-
%   output_histogramEq: Adjusted RGB image after applying histogram equalization(uint8)
%number of levels
L=256;
%check if the image is gray or not
if(size(img,3)>1)
    in_img_m=rgb2ycbcr(img);
    img= in_img_m(:,:,1);  
end
%build up the lookup table s=(L-1)*CDF(p)
%[counts,bins]=imhist(img); calc histogram of the given image
counts=zeros(256,1);
for i=0:255
    counts(i+1)=sum(sum(img==i));
end
%calc PDF of the image
p=counts/(size(img,1)*size(img,2));
%calc s=(L-1)*CDF(p)
s=(L-1)*cumsum(p);
%round the float into the nearest integare
s=round(s);
%Map the value of s to corresponding pixels in the image
out_img=uint8(zeros(size(img)));
for k=1:size(s,1)
    out_img(img==k-1)=s(k);
end
%Map the new out_put
out_img_m=in_img_m;
out_img_m(:,:,1)=out_img;
output_histogramEq=ycbcr2rgb(out_img_m);
end