%
clearvars
close all
path=uigetdir;
cd(path)

load('20well_24wp_maskData.mat')

filenames=dir('*.mp4');
for i=1:length(filenames)
    v=VideoReader(filenames(i).name);
    k=1;
    v.CurrentTime = 0;
    I1=readFrame(v);
    %tadpolen=input('please enter the number of tadpoles:');
    figure(i)
    imshow(I1);
    color=jet(tadpolen);

    for j=1:tadpolen
        figure(i)
        ROI_temp{j}=drawrectangle('Position',ROI{j}.Position,'Color',color(j,:));
        %ROI_temp{j}.Position
    end
    keyboard
    ROI
    ROI=ROI_temp

    % keyboard
    % 
    % figure
    % imshow(I1);
    % ROI_LED=drawrectangle();
    ROI_LED_temp=drawrectangle('Position',ROI_LED.Position,'Color','r')
    keyboard
    ROI_LED=ROI_LED_temp
    %keyboard

    save(strcat(filenames(i).name(1:end-4),'_maskData.mat'))
end