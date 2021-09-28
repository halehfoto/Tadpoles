%this is a function to extract heading of the tadpole
close all
% path=uigetdir;
path='C:\Users\Haleh\OneDrive - Harvard University\Documents\Tadpole Data\Tadpool/'
cd(path)
%read the avi file
filename='WIN_20210921_12_36_50_Pro.mp4';
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
    if i<3
        roi{i} = drawrectangle('Position',[316+(i-1)*280 48 201.0000 206],'Color',color(i,:));
    else
        roi{i} = drawrectangle('Position',[316+(i-3)*280 328 201.0000 206],'Color',color(i,:));
    end
end
keyboard

for i=2:numwells
    k=1;
    v.CurrentTime = 0;
    filename=strcat('Cropped_vid',num2str(i),'.avi');
    writer = VideoWriter(filename,'Uncompressed AVI');    
    open(writer)
    while hasFrame(v) && k<nFrames
        I=readFrame(v);%read the next frame and compare with first
        Ic=imcrop(I(:,:,1),roi{i}.Position);
        writeVideo(writer,Ic);
        k=k+1;
    end
    close(writer);
    clear writer;
end
