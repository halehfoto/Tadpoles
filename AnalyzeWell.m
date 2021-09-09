function [Imstd_well] = AnalyzeWell(v,nFrames,roi,imageSize)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
I_crop=zeros([imageSize,nFrames]);
k=1;
v.CurrentTime = 0;
while hasFrame(v) && k<nFrames
    I_temp=readFrame(v);
    I_crop(:,:,k)=imcrop(I_temp(:,:,1),roi.Position);
    k=k+1;
end
ImDiff=diff(I_crop,1,3);
Imstd_well=zeros(1,size(ImDiff,3));
for k=1:size(ImDiff,3)
    Imstd_well(k)=std2(ImDiff(:,:,k));
end
clear I_crop
clear ImDiff
end

