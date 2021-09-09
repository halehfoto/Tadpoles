function [Imstd_well] = AnalyzeWell(v,nFrames,roi)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
k=1;
v.CurrentTime = 0;
I1=readFrame(v);
Imstd_well=zeros(1,nFrames-1);
while hasFrame(v) && k<nFrames
    I2=readFrame(v);
    ImDiff=imcrop(I2(:,:,1),roi.Position)-imcrop(I1(:,:,1),roi.Position);
    Imstd_well(k)=std2(ImDiff);
    k=k+1;
    I1=I2;
end

clear ImDiff
end

