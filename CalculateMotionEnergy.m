%this is a  program to calculate the motion energy in a petri dish full of
%tadpoles. it first defines regions of interest. This will generate a
%circle that the user has to place on each well. In each region of interest
%then it will calculate the change in the image by first calculating the
%difference in two consecutive frames and then calculating the standard
%deviation of that image and provides one number as the output.
clearvars
close all
path=uigetdir;
cd(path)
%read the avi file
filename='Fluox+Donepezil_tadpoles072721_recover.mp4';
v=VideoReader(filename);
numperrow=input('Please enter the number of wells per row: ');
numrows=input('Please enter the number of rows: ');
nFrames=input('Please enter the number of frames to be analyzed enter [] to analyze all: ');
if isempty(nFrames)
    nFrames=v.NumFrames;
end
numwells=numperrow*numrows;
figure(1);
I=read(v,1);
imshow(I);
hold on

color=jet(numperrow*numrows);
for i=1:numwells
    if i<numperrow+1
        roi{i} = drawrectangle('Position',[179+i*200 109 182.0000 177],'Color',color(i,:));
    else
        roi{i} = drawrectangle('Position',[185+(i-3)*200 349 182.0000 177],'Color',color(i,:));
    end
end
keyboard
imageSize = size(imcrop(I(:,:,1),roi{1}.Position));
%% call the function to analyze each well
Imstd=cell(numwells);
for i=1:numwells
    Imstd{i}=AnalyzeWell(v,nFrames,roi{i},imageSize);
end
figure;
subplot(2,1,1)
hold on
imshow(I)
for i=1:numwells
    drawrectangle('Position',roi{i}.Position,'Color',color(i,:));
end
subplot(2,1,2)
hold on
time=(1:1:nFrames-1)/(v.FrameRate*60);
for i=1:numwells
    plot(time,Imstd{i},'Color',color(i,:),'LineWidth',1)
    xlabel('Time (min)') 
    ylabel('Movement Index')
end
%compare responses every five mintues
% group1=round(time/5);
% [P,ANOVATAB,STATS]=kruskalwallis(smooth(Imstd(5,:),v.FrameRate*30),group)
% figure
% multcompare(STATS)
% save('Fluox+Donepezil_tadpoles072721_recover_MvmntIDX_W6.mat')
% save('Fluox+Donepezil_tadpoles072721_recover.mat','-v7.3')