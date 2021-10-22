%this is a function to extract heading of the tadpole
function Turndir = headingdir(v,nFrames,ROI)
k=1;
v.CurrentTime = 0;
%calculate background
for i=1:10000
    I=readFrame(v);
    Ic=imcrop(I(:,:,1),ROI.Position);
    BG_temp(i,:,:)=Ic;
end
BG=squeeze(median(BG_temp(1:10000,:,:),1));
figure;imshow(BG,[])
k=1;
v.CurrentTime = 0;
I=readFrame(v);%read the first frame
head_dir=[];
figure;
It=im2bw(BG-imcrop(I(:,:,1),ROI.Position),0.2);
s=regionprops(It,'centroid');
figure;imshow(It);hold on;
for i=1:length(s)
    plot(s(i).Centroid(1),s(i).Centroid(2),'*')
    hold on
end
    
while hasFrame(v) && k<nFrames
    readFrame(v);
    %binarize the image
    Ic_temp=imcrop(I(:,:,1),ROI.Position);
    Ic=im2bw(BG-Ic_temp,0.2);
    s=regionprops(Ic,'centroid');
    imshow(Ic);
    hold on
    for i=1:length(s)
        plot(s(i).Centroid(1),s(i).Centroid(2),'*')
        hold on
    end

    I=readFrame(v);%read the first frame
    k=k+1;
    pause(1)
    clear s
end
end

