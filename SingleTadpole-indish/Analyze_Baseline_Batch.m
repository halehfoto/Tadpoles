%analyze baseline movement.
clearvars
%close all
path=uigetdir;
cd(path)
%read the avi file
filenames=dir('*baseline*.mp4')
for kk=1:length(filenames) 
    load(strcat(filenames(kk).name(1:end-4),'_maskData.mat'),'ROI','ROI_LED','tadpolen'); 
    v=VideoReader(filenames(kk).name);
    k=1;
    v.CurrentTime = 0;
    I1=readFrame(v);
    nframes=v.FrameRate*60*5;
    %find the threshold for binarizing:
    figure;
    I1ct=imcrop(I1(:,:,1),ROI{11}.Position);
    imshow(I1ct)
    thresh_im=0.3;%no screen
    % thresh_im=0.32;%with screen
    figure;
    I1bwt=im2bw(I1(:,:,1),thresh_im);
    imshow(I1bwt)
    tic
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
        k=k+1;

    end
    %calculate the displacement
    for ii=1:tadpolen
        for i=2:length(cent{ii})
            d(ii,i-1)=norm(cent{ii}(i,:)-cent{ii}(i-1,:));        
        end
        dm(ii,:)=movmean(d(ii,:),3);
        if nanstd(dm(ii,:))>1
            dm(ii,:)=NaN(size(dm(ii,:)));
        end
        dmsum(ii)=nansum(dm(ii,:));
    end

    Movment_stat=[nanmean(reshape(dm, [1,tadpolen*length(dm)])),nanstd(reshape(dm, [1,tadpolen*length(dm)]))]
    Frame_rate=v.FrameRate;
    save(strcat(filenames(kk).name(1:end-4),'_analyzed.mat'),'Movment_stat','dm','dmsum','Frame_rate')
    clear dm
    clear dmsum
    clear Movement_stat
    clear d
    clear cent
end