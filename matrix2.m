clc,clear
i_pepper = imread('peppers.png');
subplot(3,3,1), image(i_pepper)
%1.) Flip an image upside-down.
%a = flipud(i_pepper)
%or
z11=i_pepper(end:-1:1,1:end,:);
subplot(3,3,2), image(z11)
%2.) Take a color image and make it grayscale using equal weights...
b = i_pepper(1:end,1:end, 1:end);
b1 = b(1:end,1:end, 1)
b2 = b(1:end,1:end, 2)
b3 = b(1:end,1:end, 3)
KK = ((b1+b2+b3))
subplot(3,3,3),imshow(KK/3)
%3.)Swap the R and B color channels of RGB image such that R is now B...
Newpic(:,:,1)=i_pepper(:,:,1)
Newpic(:,:,2)=i_pepper(:,:,2)
Newpic(:,:,3)=i_pepper(:,:,1)
subplot(3,3,4), imshow(Newpic)
Newpic1(:,:,3)=i_pepper(:,:,3)
Newpic1(:,:,2)=i_pepper(:,:,2)
Newpic1(:,:,3)=i_pepper(:,:,3)
subplot(3,3,5), imshow(Newpic1)
Newpic2(:,:,3)=i_pepper(:,:,3)
Newpic2(:,:,2)=i_pepper(:,:,2)
Newpic2(:,:,3)=i_pepper(:,:,1)
subplot(3,3,6), imshow(Newpic2)
%4.) Rotate a grey scale image 90 degrees counter-clockwise. (you cannot use imrotate or rot90)
%i_pepper = imread('peppers.png')
%rotate_i_pepper = permute(i_pepper,[2 1 3])
%a1=rotate_i_pepper(:,end:-1:1,:)
%or

%a1= fliplr(rotate_i_pepper)

% Or
%4.) Rotate a grey scale image 90 degrees counter-clockwise. (you cannot use imrotate or rot90)
i_pepper = imread('peppers.png')
b = i_pepper(1:end,1:end, 1:end);
b1 = b(1:end,1:end, 1)
b2 = b(1:end,1:end, 2)
b3 = b(1:end,1:end, 3)
B1= b1'
B2=b2'
B3= b3'
Z =zeros(512,384,3);                 
Z(:, :, 1)= B1;
Z(:, :, 2) = B2;
Z(:, :, 3) =B3;
a1=Z(:,end:-1:1,:)
subplot(3,3,7), imshow(a1 ./ 255);
KKK= KK'
KKK1 = KKK(:,end:-1:1,:)
subplot(3,3,8), imshow(KKK1/3)
%5.) Create a 12 by 12 by 3 "image" using the matrix from part 1...
A = [ 1:12; 13:24; 25:36; 37:48; 49:60; 61:72; 73:84; 85:96; 97:108; 109:120; 121:132; 133:144]
Z =zeros(12,12,3);                 
Z(:, :, 1)= A;
Z(:, :, 2) = A;
Z(:, :, 3) = A;
%imshow(Z/144);
sd= reshape(Z,[144,3])
zxx= reshape(sd,[12,12,3])
