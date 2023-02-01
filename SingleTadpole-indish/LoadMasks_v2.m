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
    figure(1)
    imshow(I1);
    color=jet(tadpolen);

    for j=1:tadpolen
        figure(1)
        drawrectangle('Position',ROI{j}.Position,'Color',color(j,:));

        %keyboard
    end
    % keyboard
    % 
    % figure
    % imshow(I1);
    % ROI_LED=drawrectangle();
    drawrectangle('Position',ROI_LED.Position,'Color','r')
    %keyboard

    save(strcat(filenames(i).name(1:end-4),'_maskData.mat'))
end