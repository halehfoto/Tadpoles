%this is a  program to calculate the motion energy in a petri dish full of
%tadpoles. it first defines regions of interest. This will generate a
%circle that the user has to place on each well. In each region of interest
%then it will calculate the change in the image by first calculating the
%difference in two consecutive frames and then calculating the standard
%deviation of that image and provides one number as the output.
clearvars
close all
% path=uigetdir;
path='C:\Users\Haleh\OneDrive - Harvard University\Documents\Tadpole Data\habituation\20210930'
cd(path)
%read the avi file
filename='WIN_20210930_14_10_00_Pro.mp4';
v=VideoReader(filename);
numwells=input('Please enter the number of wells : ');
nFrames=input('Please enter the number of frames to be analyzed enter [] to analyze all: ');
if isempty(nFrames)
    nFrames=v.NumFrames;
end

%extract the value of the LED for each fram
figure(1);
I=read(v,1);
imshow(I);
hold on

roi_LED = drawrectangle();
keyboard


color=jet(numwells);
%this draws squares around each well that can be repositined by the user on
%each well
for i=1:numwells
        roi{i} = drawrectangle();
end
keyboard
imageSize = size(imcrop(I(:,:,1),roi{1}.Position));
%% call the function to analyze each well
Imstd=cell(numwells);
for i=1:numwells
    [welldata,leddata]=AnalyzeWell_LED(v,nFrames,roi{i},roi_LED);
    Imstd{i}=welldata;
    LED=leddata;
end
time=(1:1:nFrames-1)/(v.FrameRate);

figure;
% hold on
% imshow(I)
% for i=1:numwells
%     drawrectangle('Position',roi{i}.Position,'Color',color(i,:));
% end.
% subplot(2,1,2)
hold on
st=smooth(Imstd{i}(1:nFrames-1),10);

for i=1:numwells
    plot(time(1:nFrames-1),detrend(st(1:nFrames-1)),'Color',color(i,:),'LineWidth',1)
    xlabel('Time (s)') 
    ylabel('Movement Index')
end
axis tight
plot(time,LED/max(LED))
hold on
axis tight

stbpf=bandpass(Imstd{i},[0.1,7],v.FrameRate);
figure
plot(stbpf);
figure;spectrogram(stbpf,200,10,0:0.01:5,v.FrameRate,'yaxis')%compare responses every five mintues
% group=round(time/5);
% [P,ANOVATAB,STATS]=kruskalwallis(smooth(Imstd{5}(1:nFrames-10),v.FrameRate*30),group)
% figure
% multcompare(STATS)
save('WIN_20210930_14_10_00_Pro.mat')
% save('Fluox+Donepezil_tadpoles072721_recover.mat','-v7.3')