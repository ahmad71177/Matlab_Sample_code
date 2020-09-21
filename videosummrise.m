clc;
clear;
close all;
% --------------- Make a video from frames --------------------
myFolder = 'C:\Users\Ahmad\Desktop\Skating1\Skating1\img';%add orginal frame folder location
filePattern = fullfile(myFolder, '*.jpg');
pngFiles = dir(filePattern);
%----------------Open the video writer object------------------
writerObj = VideoWriter('YourAVI.avi');
writerObj.FrameRate = 10;
open(writerObj)
for frameNumber = 1 : length(pngFiles)
baseFileName = pngFiles(frameNumber).name;
fullFileName = fullfile(myFolder, baseFileName);
thisimage = imread(fullFileName);
writeVideo(writerObj, thisimage);
end
% Close down the video writer object to finish the file.
close(writerObj);
% --------------------- Read a video ---------------------------
t = cputime;
position = [450 50];
vid=VideoReader('YourAVI.avi');
videoFileReader = vision.VideoFileReader('YourAVI.avi');
count= 0;
count2= 1;
while ~isDone(videoFileReader)
% Read a video frame and run the detector.
videoFrame = step(videoFileReader);
count= count+1;
end
writerObj = VideoWriter('V2-Summary2');
open(writerObj);
bg = read(vid,1); % Read in 1st frame as background frame
bg_bw = rgb2gray(bg); % Convert background to greyscale
n=count;
writeVideo(writerObj, bg);
bg1= insertText(bg,position,'F#1', 'FontSize',18);
imwrite(bg1,['C:\Users\Ahmad\Desktop\videosum\' int2str(count2),'.jpg']);%add the destination location folder to save key frame
% --------------------- Process frames ----------------------------
s=zeros(n,1);
for i = 2:n
fr = read(vid,i); % Read in frame
fr_bw = rgb2gray(fr); % Convert frame to grayscale
fr_diff = sum(abs(double(fr_bw) - double(bg_bw))); % Cast operands as double to avoid negative overflow
if std2(fr_diff)>6500 % This threshold value is selected by the author depending on the input video
s(i)=std2(fr_diff);
rgb= insertText(fr,position,['F#' int2str(i)],'FontSize',18);%in this line we can write text on the frame
% --------------------- write new frames -------------------------
imwrite(rgb,['C:\Users\Ahmad\Desktop\videosum\', int2str(count2+1), '.jpg']);%add the destination location folder to save key frame
count2= count2+1;
% --------------------- write new video -------------------------
writeVideo(writerObj, rgb);
end
figure(1),subplot(3,1,1),imshow(fr)
subplot(3,1,2),plot(fr_diff)
subplot(3,1,3),plot(s)
end
close(writerObj);
% --------------------- time per frame -------------------------
zz = t / count;
timeperframe = zz;