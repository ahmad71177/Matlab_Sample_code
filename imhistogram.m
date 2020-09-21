function  output_histogram =imhistogram(img,bin)
switch nargin
    case 3
        img=rgb2gray(img);
end 
[x, y] = size(img); 
c=x*y
for i = 0 : bin
  frequency(i+1) =sum(sum(img==i));
end
output_histogram=frequency;
H_PDF=frequency./c;
[r c]=size(H_PDF);
c_hist=zeros(1,256);
for j=1:c
    if(j ==1)
       c_hist(j)=H_PDF(j);
    else
       c_hist(j)=H_PDF(j)+c_hist(j-1);
    end
end
end