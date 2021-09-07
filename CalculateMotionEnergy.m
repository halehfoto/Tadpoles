%this is a  program to calculate the motion energy in a petri dish full of
%tadpoles. it first defines regions of interest. This will generate a
%circle that the user has to place on each well. In each region of interest
%then it will calculate the change in the image by first calculating the
%difference in two consecutive frames and then calculating the standard
%deviation of that image and provides one number as the output.
path=uigetdir;
cd(path)
%read the avi file
filename=dir('*.mp4');
v=VideoReader(filename.name);
video=read(v);
figure(1);
imshow(video(:,:,:,1))
color=jet(6);
for i=1:6
    if i<4
        roi{i} = drawcircle('Center',[335+i*150 254],'Radius',90,'Color',color(i,:));
    else
        roi{i} = drawcircle('Center',[335+(i-3)*150 254+150],'Radius',90,'Color',color(i,:));
    end
end

% for i=1:6
%      roi1{i} = images.roi.Circle
%      figure(1)
%      draw(roi1{i})
% end