%this is to make an example video of the tracking.
clearvars
%close all
% path=uigetdir;
path='C:\Users\Haleh\OneDrive - Harvard University\Documents\Tadpole Data\habituation\20211007\ISI3s'
cd(path)
%read the avi file
filename='WIN_20211007_14_56_14_Pro.mp4';
load('WIN_20211007_14_56_14_Pro_maskData.mat')    
load('WIN_20211007_14_56_14_Pro_analyzed.mat')
vout = VideoWriter('Example_tracking.avi');
vout.Quality = 95;
vout.FrameRate=v.FrameRate;
open(vout)
v=VideoReader(filename);
k=1;
v.CurrentTime = 0;
figure
n=4;
for i=1:27000
    I1=readFrame(v);
    I1c=imcrop(I1(:,:,1),ROI{n}.Position);
    imshow(I1c);
    hold on
    if i==1
        plot(cent{n}(i,1),cent{n}(i,2),'g.')
    else
        temp=i-1;
        if ismember(temp,LOCSS)
            plot(7,7,'R*')
        end
        if d(n,i)>5
            plot(cent{n}(i,1),cent{n}(i,2),'r.')
        else
            plot(cent{n}(i,1),cent{n}(i,2),'g.')
        end
    end
    drawnow
    frame=getframe(gcf);
    writeVideo(vout,frame)
end
close(vout);
