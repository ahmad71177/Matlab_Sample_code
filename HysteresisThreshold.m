
function BinaryEdgeImage = HysteresisThreshold(magnitudeImage,minThresh,maxThresh)

% Hystersis by bwselect

I_low=magnitudeImage>minThresh;
[x,y]=find(magnitudeImage>maxThresh);

 BinaryEdgeImage = bwselect(I_low, y, x);