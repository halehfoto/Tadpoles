%this is a program to track a single tadpole
clearvars
%close all
% path=uigetdir;
path='C:\Users\Haleh\OneDrive - Harvard University\Documents\Tadpole Data\habituation\20211007\ISI10s'
cd(path)
%read the avi file
filename='WIN_20211007_15_26_36_Pro.mp4';
load('WIN_20211007_15_26_36_Pro_maskData.mat')    
v=VideoReader(filename);
k=1;
v.CurrentTime = 0;
I1=readFrame(v);
tadpolen=input('please enter the number of tadpoles:');
nframes=input('please enter the number of frames to be analyzied, enter [] to analyze all:');
if isempty(nframes)
    nframes=v.NumFrames;
end


figure
while hasFrame(v) && k<nframes
    %for each tadpole, apply the mask and calculate center of mass 
    %convert to bw and detect center of mass
    for i=1:tadpolen
        I1c{i}=imcrop(I1(:,:,1),ROI{i}.Position);
        I1bw{i}=im2bw(I1c{i},0.1);
        C=regionprops(1-I1bw{i},'Centroid');
        if ~isempty(C)
            cent{i}(k,:)=C.Centroid;
        else
            cent{i}(k,:)=[NaN, NaN];
        end
    end
    I0=I1;
    I1=readFrame(v);%read the first frame
    LEDDiff=imcrop(I1(:,:,1),ROI_LED.Position)-imcrop(I0(:,:,1),ROI_LED.Position);
    LED(k)=std2(LEDDiff);%calculate standard deviation across all pixel values within ROI
    k=k+1;

    for i=1:tadpolen
        I1c{i}=imcrop(I1(:,:,1),ROI{i}.Position);
        for ii=1:size(mask{i},1)
            for j=1:size(mask{i},2)
                if mask{i}(ii,j)==0
                    I1c{i}(ii,j)=150;
                end
            end
        end
    end

    
end
%calculate the displacement
for ii=1:tadpolen
    for i=2:length(cent{ii})
        d(ii,i-1)=norm(cent{ii}(i,:)-cent{ii}(i-1,:));
    end
end
time=1/v.FrameRate:1/v.FrameRate:(nframes-1)/v.FrameRate;
dlpm=lowpass(nanmean(d),0.2);
figure;
%find the stimulus time
thresh_led=15;
[PKSS,LOCSS]=findpeaks(LED,'MinPeakHeight',thresh_led,'MinPeakDistance',v.FrameRate*3);
thresh_amp=5;
for i=1:length(LOCSS)
    line([time(LOCSS(i)),time(LOCSS(i))],[-1,5],'Color','g')
    hold on
    for j=1:tadpolen
        if max([d(j,LOCSS(i)+1),d(j,LOCSS(i)+2),d(j,LOCSS(i)+3),d(j,LOCSS(i)+4)])>thresh_amp
            Resp(j,i)=1;
        else
            Resp(j,i)=0;

        end
    end
end
plot(time(2:end),dlpm,'LineWidth',1)
plot(time,LED)
hold on
figure;
%plot(time, LED);
hold on
for i=1:tadpolen
    subplot(tadpolen,1,i)
    plot(time(2:end),d(i,:))
    hold on
    for j=1:length(LOCSS)
        line([time((LOCSS(j))+1),time((LOCSS(j))+1)],[-1,15],'Color','g')
        hold on
        if Resp(i,j)==1
            plot(time((LOCSS(j)+1)),5,'r*')
        else
            plot(time((LOCSS(j)+1)),0,'k*')
        end
    end
%     xlim([0,700])
    %axis tight
end
%the first LED light is missing
figure; 
%plot(1:20,[1,mean(Resp(:,1:19),1)])
x=(1:20)';
y=(mean(Resp(:,1:20),1))';
f=fit(x,y,'exp1');
plot(x,y)
hold on
plot(f,x,y)

x=(25:44)';
y=(mean(Resp(:,21:40),1))';
f=fit(x,y,'exp1')
plot(x,y)
plot(f,x,y)

x=(50:69)';
y=(mean(Resp(:,41:60),1))';
f=fit(x,y,'exp1')
plot(x,y)
plot(f,x,y)

x=(75:94)';
y=(mean(Resp(:,60:79),1))';
f=fit(x,y,'exp1')
plot(x,y)
plot(f,x,y)


save('WIN_20211007_15_26_36_Pro_analyzed.mat')
