clc
clear
close all
%i = imread('peppers.png');
%o = imhistogram_eq(i);
%Z= histeq(i);
%figure,subplot(3,2,2), imshow(i);
%title('Before my Histogram equalization');
%subplot(3,2,4),imshow(o);
%title('After my Histogram equalization');
%subplot(3,2,6),imshow(Z);
%title('After matlab histeq function');

B= imread('office_5.jpg');
C=histeq(B);
K=imhistogram_eq(B);
subplot(3,2,1),imshow(B);
title('Before matlab histeq function');
subplot(3,2,5), imshow(C);
%title('After matlab histeq function');
%subplot(3,2,3),imshow(K);
%title('After my Histogram equalization');

%cos_similarity = dot(o,Z)/(norm(o)*norm(Z)); 