
function newMagnitudeImage = NonMaximalSuppression(magnitude,orientation)
orientation=(orientation*180/pi); %change radian to degree
% hard thresholding the orientation into 0,45,90,135
orientation(orientation < 22.5 & orientation >= 360-22.5) = 0;
orientation(orientation < 67.5 & orientation >= 22.5 ) = 45;
orientation(orientation < 112.5 & orientation >= 67.5 | orientation >= -112.5+360 & orientation < -67.5+360) = 90;
orientation(orientation < 157.5 & orientation >= 112.5) = 135;
orientation(orientation < 157.5+180 & orientation >= 112.5+180) = 135;
orientation(orientation >= 157.5 | orientation < 180-112.5) = 0;
orientation(orientation < 67.5+180 & orientation >= 22.5+180 ) = 45;
% finding local maxima in the direction of orientation
maxmask=zeros(size(magnitude,1),size(magnitude,2));
for i=2:size(magnitude,1)-1
    for j=2:size(magnitude,2)-1
        if (orientation(i,j)==0)
            maxmask(i,j)=(magnitude(i,j)>magnitude(i,j+1))& (magnitude(i,j)>magnitude(i,j-1));
 
        end
        if (orientation(i,j)==135)
            maxmask(i,j)=(magnitude(i,j)>magnitude(i+1,j-1))& (magnitude(i,j)>magnitude(i-1,j+1));
 
        end
        if (orientation(i,j)==90)
            maxmask(i,j)=(magnitude(i,j)>magnitude(i+1,j))& (magnitude(i,j)>magnitude(i-1,j));
   
        end
        if (orientation(i,j)==45)
            maxmask(i,j)=(magnitude(i,j)>magnitude(i-1,j-1))& (magnitude(i,j)>magnitude(i+1,j+1));
        
        end

    end
end
newMagnitudeImage=magnitude.*maxmask;
end