function [Imstd_well,LED] = AnalyzeWell_LED(v,nFrames,roi,roi_LED)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
k=1;
v.CurrentTime = 0;
I1=readFrame(v);%read the first frame
Imstd_well=zeros(1,nFrames-1);
LED=zeros(1,nFrames-1);
while hasFrame(v) && k<nFrames
    I2=readFrame(v);%read the next frame and compare with first
    ImDiff=imcrop(I2(:,:,1),roi.Position)-imcrop(I1(:,:,1),roi.Position);
    LEDDiff=imcrop(I2(:,:,1),roi_LED.Position)-imcrop(I1(:,:,1),roi_LED.Position);
    Imstd_well(k)=std2(ImDiff);%calculate standard deviation across all pixel values within ROI
    LED(k)=std2(LEDDiff);%calculate standard deviation across all pixel values within ROI

    k=k+1;
    I1=I2;
end

clear ImDiff
end

