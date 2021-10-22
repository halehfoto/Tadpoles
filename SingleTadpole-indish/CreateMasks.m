%To analyze multi-well tadpole data at single tadpole level run this first to create masks for each vial. 
clearvars
close all
% path=uigetdir;
path='C:\Users\Haleh\OneDrive - Harvard University\Documents\Tadpole Data\habituation\20211021\ISI 4s'
cd(path)
%read the avi file
filename='WIN_20211021_15_46_04_Pro';
v=VideoReader(strcat(filename,'.mp4'));
k=1;
v.CurrentTime = 0;
I1=readFrame(v);
tadpolen=input('please enter the number of tadpoles:');
figure(1)
imshow(I1);
color=jet(tadpolen);
for i=1:tadpolen
    
    figure(1)
    if i==1
        ROI{i}=drawrectangle();
    else
        ROI{i}=drawrectangle('Position',ROI{i-1}.Position,'Color',color(i,:));
    end
    keyboard

    %crop image
    I1c{i}=imcrop(I1(:,:,1),ROI{i}.Position);
    figure;
    imshow(I1c{i})
    %define the circular mask
    if i==1
        ROI_c{i}=drawcircle();
    else
        ROI_c{i}=drawcircle('Center',ROI_c{i-1}.Center,'Radius',ROI_c{i-1}.Radius,'Color',color(i,:));
    end
    keyboard
    imageSize= size(I1c{i});
    ci=[ROI_c{i}.Center,ROI_c{i}.Radius];
    [xx,yy]=ndgrid((1:imageSize(1))-ci(2),(1:imageSize(2))-ci(1));
    mask{i} = uint8((xx.^2 + yy.^2)<ci(3)^2);
    for k=1:size(mask{i},1)
        for j=1:size(mask{i},2)
            if mask{i}(k,j)==0
                I1c{i}(k,j)=150;
            end
        end
    end
end
figure
imshow(I1);
ROI_LED=drawrectangle();
keyboard
save(strcat(filename,'_maskData.mat'))