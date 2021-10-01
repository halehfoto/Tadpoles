%this is a program that calculates sumulative movement on each of the wells
%for each tadpole
clearvars
close all
% path=uigetdir;
path='C:\Users\Haleh\OneDrive - Harvard University\Documents\Tadpole Data\habituation\20210929'
cd(path)
%read the avi file
filename='WIN_20210929_18_42_12_Pro.mp4';
v=VideoReader(filename);
numwells=input('Please enter the number of wells : ');
nFrames=input('Please enter the number of frames to be analyzed enter [] to analyze all: ');
if isempty(nFrames)
    nFrames=v.NumFrames;
end
figure(1);
I=read(v,1);
imshow(I);
hold on

color=jet(numwells);
%this draws squares around each well that can be repositined by the user on
%each well
for i=1:numwells
      if i<=numwells/8
        roi{i} = drawrectangle('Position',[320+(i-1)*81 81 64.0000 66],'Color',color(i,:));
      elseif i<=numwells/4
        roi{i} = drawrectangle('Position',[320+(i-1)*81 81 64.0000 66],'Color',color(i,:));
      elseif i<=numwells/2
          roi{i} = drawrectangle('Position',[320+(i-1)*81 81 64.0000 66],'Color',color(i,:));
      else
          roi{i} = drawrectangle('Position',[320+(i-1)*81 81 64.0000 66],'Color',color(i,:));
      end
        

end
keyboard