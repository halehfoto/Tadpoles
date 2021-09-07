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
figure(1);
I=read(v,1);
imshow(I)
color=jet(6);
for i=1:6
    if i<4
        roi{i} = drawrectangle('Position',[179+i*200 109 182.0000 177],'Color',color(i,:));
    else
        roi{i} = drawrectangle('Position',[185+(i-3)*200 349 182.0000 177],'Color',color(i,:));
    end
end
keyboard
imageSize = size(I);
%crop images;
tic
I_crop=cell(6);
for i=1:6
    I_crop{i}=zeros(size(imcrop(I(:,:,1),roi{1}.Position)));
end
k=1;
v.CurrentTime = 0;
while hasFrame(v)
        I_temp=readFrame(v);
        for i=1:6
            I_crop{i}(:,:,k)=imcrop(I_temp(:,:,1),roi{i}.Position);
        end
        k=k+1;
end
tic
ImDiff=cell(6);
for i=1:6
    ImDiff{i}=diff(I_crop{i},1,3);%calculate the difference image
end
toc
for i=1:6
    for k=1:size(ImDiff{i},3)
        Imstd(i,k)=std2(ImDiff{i}(:,:,k));
    end
end
figure;
subplot(2,1,1)
hold on
imshow(I)
for i=1:6
    drawrectangle('Position',roi{i}.Position,'Color',color(i,:));
end
subplot(2,1,2)
hold on
time=(1:1:size(Imstd,2))/(v.FrameRate*60);
for i=1:6
    plot(time,smooth(Imstd(i,:),v.FrameRate*30),'Color',color(i,:),'LineWidth',1)
    xlabel('Time (min)') 
    ylabel('Movement Index')
end
%compare responses every five mintues
group1=round(time/5);
[P,ANOVATAB,STATS]=kruskalwallis(smooth(Imstd(5,:),v.FrameRate*30),group)
figure
multcompare(STATS)
save('Fluox+Donepezil_tadpoles072721_recover_MvmntIDX.mat')
save('Fluox+Donepezil_tadpoles072721_recover.mat','-v7.3')