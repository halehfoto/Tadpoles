%To analyze multi-well tadpole data at single tadpole level run this first to create masks for each vial. 
clearvars
close all
% path=uigetdir;
path='C:\Users\Haleh\OneDrive - Harvard University\Documents\Tadpole Data\habituation\20211007\ISI10s'
cd(path)
%read the avi file
filename='WIN_20211007_15_26_36_Pro.mp4';
v=VideoReader(filename);
k=1;
v.CurrentTime = 0;
I1=readFrame(v);
tadpolen=input('please enter the number of tadpoles:');
figure(1)
imshow(I1);

for i=1:tadpolen
    figure(1)
    ROI{i}=drawrectangle();
    keyboard
    %crop image
    I1c{i}=imcrop(I1(:,:,1),ROI{i}.Position);
    figure;
    imshow(I1c{i})
    %define the circular mask
    ROI_c{i}=drawcircle();
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
save('WIN_20211007_15_26_36_Pro_maskData.mat')