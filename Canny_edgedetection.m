% DO NOT MODIFY THIS FILE
% DO NOT SUBMIT THIS FILE
close all
clear all
clc
% Read and display an image
load BrainWeb
figure(1), imshow(I)

%%%%%%% sigma 1 %%%%%%%%%%
[mag1,dir1] = EdgeFilter(I, 1);
figure(2), imshow(mag1/max(mag1(:)))
nonmax_supp1 = NonMaximalSuppression(mag1,dir1);
figure(3), imshow(nonmax_supp1/max(nonmax_supp1(:)))
bin1 = HysteresisThreshold(nonmax_supp1,0.03, 0.07);
figure(4), imshow(bin1), title('sigma 1')

display('Press any key to continue')
pause

%%%%%%% sigma 2 %%%%%%%%%%
[mag2,dir2] = EdgeFilter(I, 2);
figure(1), imshow(mag2/max(mag2(:)))
nonmax_supp2 = NonMaximalSuppression(mag2,dir2);
figure(2), imshow(nonmax_supp2/max(nonmax_supp2(:)))
bin2 = HysteresisThreshold(nonmax_supp2,0.03, 0.07);
figure(3), imshow(bin2), title('sigma 2')

display('Press any key to continue')
pause

%%%%%%% sigma 4 %%%%%%%%%%
[mag4,dir4] = EdgeFilter(I, 4);
figure(1), imshow(mag4/max(mag4(:)))
newmag4 = NonMaximalSuppression(mag4,dir4);
figure(2), imshow(newmag4/max(newmag4(:)))
bin4 = HysteresisThreshold(newmag4,0.03, 0.07);
figure(3), imshow(bin4), title('sigma 4')

display('Press any key to continue')
pause

%%%%%%% sigma 8 %%%%%%%%%%
[mag8,dir8] = EdgeFilter(I, 8);
figure(1), imshow(mag8/max(mag8(:)))
newmag8 = NonMaximalSuppression(mag8,dir8);
figure(2), imshow(newmag8/max(newmag8(:)))
bin8 = HysteresisThreshold(newmag8,0.03, 0.07);
figure(3), imshow(bin8), title('sigma 8')