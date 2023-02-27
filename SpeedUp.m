%this is a program that opens a video and saves a downsampled version of
%it.
clearvars
close all
path='\\research.files.med.harvard.edu\Wyss Institute\Levin Lab\Haleh';
cd(path)
path2=uigetdir;
cd(path2)
filename=uigetfile;
speedup=input('Please enter the time interval you need in between frames in seconds:') 
v1=VideoReader(filename);

v2=VideoWriter(strcat(num2str(speedup),'_secinterval',filename));
open(v2);
i=1;
while hasFrame(v1)
    if i<v1.NumFrames
        k=read(v1,i);
        v2.writeVideo(k)
    else
        break;
    end
    i=i+round(speedup*v1.FrameRate);
end
close(v2);
