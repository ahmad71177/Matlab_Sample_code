clc
clear
img = imread('peppers.png);  
img=rgb2gray(img); 
[x, y] = size(img); 
c=x*y
for i = 0 : 255
  frequency(i+1) =sum(sum(img==i));
end
a=frequency
b=imhist(img)
cos_similarity = 1 - dot(a,b)/(norm(a)*norm(b));