%
clearvars
close all
path=uigetdir;
cd(path)

load('20well_24wp_maskData.mat')
filename='20220308_17_29_50_KB-R5uM_post_baseline';
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
    drawrectangle('Position',ROI{i}.Position,'Color',color(i,:));
    %keyboard
end
keyboard

figure
imshow(I1);
ROI_LED=drawrectangle();
keyboard
save(strcat(filename,'_maskData.mat'))
