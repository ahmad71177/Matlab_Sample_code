
function [magnitude,orientation] = EdgeFilter(image, sigma)

length_G = ceil(3*sigma);
G_v = -length_G:length_G ;
G = exp(-G_v.^2/2/sigma^2);
G = G/sum(G);
G_2D = G'*G;

SmoothIM = conv2(image, G_2D, 'same');% or SmoothIM = imfilter(image, G_2D);

xx = imfilter(SmoothIM, [1 0 -1]);
yy = imfilter(SmoothIM, [1 0 -1]');

magnitude = sqrt(xx.^2 + yy.^2);
orientation = atan2(yy,xx);
