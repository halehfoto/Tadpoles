%this is a program to track a single tadpole
clearvars
%close all
path=uigetdir;
cd(path)
%read the avi file
filename='20220215_11_28_27__nT10_ISI3s_IBI3m_nB5_R30m';
load(strcat(filename,'_maskData.mat')); 
v=VideoReader(strcat(filename,'.mp4'));
k=1;
v.CurrentTime = 0;
I1=readFrame(v);
tadpolen=input('please enter the number of tadpoles:');
nframes=input('please enter the duration to be analyzied in seconds, enter [] to analyze all:');
ISI=input('please enter ISI in seconds:')
% nframes=Duration*v.FrameRate;
if isempty(nframes)
    nframes=v.NumFrames;
end
%find the threshold for binarizing:
% figure;
I1ct=imcrop(I1(:,:,1),ROI{1}.Position);
imshow(I1ct)
thresh_im=0.3;
figure
I1bwt=im2bw(I1ct,thresh_im);
imshow(I1bwt)
figure;
imshow(I1ct)
tic
figure
while hasFrame(v) && k<nframes
    %for each tadpole, apply the mask and calculate center of mass 
    %convert to bw and detect center of mass
    for i=1:tadpolen
        I1c{i}=imcrop(I1(:,:,1),ROI{i}.Position);
        I1bw{i}=im2bw(I1c{i},thresh_im);
        BW=1-I1bw{i};
%         figure;imshow(BW)
        CC=bwconncomp(BW);
        %Determine which is the largest component in the image
        numPixels = cellfun(@numel,CC.PixelIdxList);
        [biggest,idx] = max(numPixels);
        %set all other ones to 1
        index=1:length(numPixels);
        index(idx)=[];
        for m=1:length(index)
            BW(CC.PixelIdxList{index(m)}) = 0;
        end
%         figure;imshow(BW)
        C=regionprops(BW,'Centroid');
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
% dlpm=lowpass(nanmean(d),0.2);
figure;
%find the stimulus time
thresh_led=30;
[PKSS,LOCSS]=findpeaks(LED,'MinPeakHeight',thresh_led,'MinPeakDistance',v.FrameRate*3);
figure;
plot(time,LED);
hold on
plot(time(LOCSS),LED(LOCSS),'r*')
thresh_amp=10;
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
figure
plot(time(2:end),d,'LineWidth',1)
hold on
plot(time,LED)
hold on
figure;
plot(time, LED);
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
% for i=1:1
%     x=(20*(i-1)+1:20*i)';
%     y=(mean(Resp(:,20*(i-1)+1:20*i),1))';
%     f=fit(x,y,'exp1');
%     plot(x,y)
%     hold on
%     plot(f,x,y)
%     legend 'off'
% end
close all
resp_prob=mean(Resp,1);
hold on
save(strcat(filename,'_analyzed.mat'))
% f=fit((1:1:20)',(resp_prob(1:20))','exp1')
% figure(1); plot(f,(1:1:20)',(resp_prob(1:20))');hold on
% plot(1:1:20,resp_prob(1:20),'g*');hold on
% 
% f2=fit((21:1:40)',(resp_prob(21:40))','exp1');
% plot(f2,(21:1:40)',(resp_prob(21:40))');hold on
% plot((21:1:40),resp_prob(21:40),'b*');hold on
% 
% f3=fit((41:1:60)',(resp_prob(41:60))','exp1');
% plot(f3,(41:1:60)',(resp_prob(41:60))');hold on
% plot(41:1:60,resp_prob(41:60),'m*');hold on
% 
% f4=fit((101:1:120)',(resp_prob(101:120))','exp1');
%  plot(f4,((101:1:120))',(resp_prob(101:120))');hold on
% plot((101:1:120),resp_prob(101:120),'c*');hold on
% 
% f5=fit((121:1:140)',(resp_prob(121:140))','exp1');
%  plot(f5,((121:1:140))',(resp_prob(121:140))');hold on
% plot((121:1:140),resp_prob(121:140),'c*');hold on
% 
% f6=fit((141:1:160)',(resp_prob(141:160))','exp1');
%  plot(f6,((141:1:160))',(resp_prob(141:160))');hold on
% plot((141:1:160),resp_prob(141:160),'c*');hold on

toc


