%this is a program to track a single tadpole
clearvars
close all
path=uigetdir;
cd(path)
%read the avi file
filenames=dir('*nT20*.mp4');
for ii=1:length(filenames)
filename=filenames(ii).name;
load(strcat(filename(1:end-4),'_maskData.mat'),'ROI','ROI_LED'); 

v=VideoReader(filename);
k=1;
v.CurrentTime = 0;
I1=readFrame(v);
tadpolen=20;
nframes=[];
ISI=3;
% tadpolen=input('please enter the number of tadpoles:');
% nframes=input('please enter the duration to be analyzied in seconds, enter [] to analyze all:');
% ISI=input('please enter ISI in seconds:')
% nframes=Duration*v.FrameRate;
if isempty(nframes)
    nframes=v.NumFrames;
end
%find the threshold for binarizing:
% figure;
I1ct=imcrop(I1(:,:,1),ROI{11}.Position);
 imshow(I1ct)
thresh_im=0.27;%no screen
% thresh_im=0.32;%with screen
%thresh_im=0.43;%with screen top and side

figure
I1bwt=im2bw(I1ct(:,:,1),thresh_im);
imshow(I1bwt)
%figure;
I1bwt=im2bw(I1(:,:,1),thresh_im);
%imshow(I1bwt)
% close all
tic
%figure
while hasFrame(v) && k<nframes
    %for each tadpole, apply the mask and calculate center of mass 
    %convert to bw and detect center of mass
    I1bwt=im2bw(I1(:,:,1),thresh_im);
    
    for i=1:tadpolen
        I1c=imcrop(I1bwt,ROI{i}.Position);
        %I1bw{i}=im2bw(I1c{i},thresh_im);
        BW=1-I1c;
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

%     for i=1:tadpolen
%         I1c{i}=imcrop(I1(:,:,1),ROI{i}.Position);
%         for ii=1:size(mask{i},1)
%             for j=1:size(mask{i},2)
%                 if mask{i}(ii,j)==0
%                     I1c{i}(ii,j)=150;
%                 end
%             end
%         end
%     end

    
end
toc
%calculate the displacement
for jj=1:tadpolen
    for i=2:length(cent{jj})
        d(jj,i-1)=norm(cent{jj}(i,:)-cent{jj}(i-1,:));
    end
end

time=1/v.FrameRate:1/v.FrameRate:(nframes-1)/v.FrameRate;
% dlpm=lowpass(nanmean(d),0.2);
%find the stimulus time
thresh_led=20;
esc_thresh=3;%escape threshold pick this empirically depends on the video quality, check the traces
[PKSS,LOCSS]=findpeaks(LED,'MinPeakHeight',thresh_led,'MinPeakDistance',v.FrameRate*2);
for i=1:length(LOCSS)
   % line([time(LOCSS(i)),time(LOCSS(i))],[-1,5],'Color','g')
%     hold on
    for j=1:tadpolen

        dm(j,:)=movmean(d(j,:),2);
        thresh=4*nanstd(dm(j,:));
        dmd(j,:)=diff(dm(j,:));
%         figure(j);plot(time, LED/max(LED))
%     hold on
%     plot(time(LOCSS),2*PKSS/max(PKSS),'g*')
%    figure(j)
%     plot(time(2:end),dm(j,:),'k')

        %if the tadpole was not swimming a lot when the LED flashed and
        %startled after
%         if dm(j,LOCSS(i)-3)> thresh
%             Resp(j,i)=NaN;
%         elseif max([dm(j,LOCSS(i)+1),dm(j,LOCSS(i)+2),dm(j,LOCSS(i)+3),dm(j,LOCSS(i)+4),dm(j,LOCSS(i)+5)])>thresh
%             Resp(j,i)=1;
%         else
%             Resp(j,i)=0;
% 
%         end
        Max_rate=max([dmd(j,LOCSS(i)),dmd(j,LOCSS(i)+1),dmd(j,LOCSS(i)+2),dmd(j,LOCSS(i)+3),dmd(j,LOCSS(i)+4)]);
        if dmd(j,max(LOCSS(i)-5,1))> 1 || Max_rate>80 || isnan(Max_rate)
            Resp(j,i)=NaN;
        elseif Max_rate>esc_thresh && Max_rate<=80
            Resp(j,i)=1;
        else
            Resp(j,i)=0;

        end
%         hold on
%         if Resp(j,i)==1
%             plot(time(LOCSS(i)), 5,'r*')
%         elseif Resp(j,i)==0
%             plot(time(LOCSS(i)), 5,'b*')
%         else
%              plot(time(LOCSS(i)), 5,'c*')
%         end
            

            

    end
end

dm_pool=[];
for i=1:tadpolen
    dm_pool=[dm_pool,dm(i,:)];

end
resp_prob=NaN(tadpolen,1);
resp_prob(1:length(LOCSS))=nanmean(Resp,1);
    
% figure;plot(resp_prob,'g*-');hold on
% f=fit((1:1:20)',(resp_prob(1:20)),'exp1');plot(f,(1:1:20)',(resp_prob(1:20))')
save(strcat(filename(1:end-4),'_analyzed.mat'))
ii
clearvars -except filenames
end
toc


