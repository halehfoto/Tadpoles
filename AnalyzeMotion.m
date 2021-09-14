%this is a program to perform statistical analysis on the movement profile
%of the tadpoles
%test this change test
clearvars
close all
path=uigetdir;
cd(path)

stasis=load('Fluox+Donepezil_tadpoles072721_MvmntIDX.mat');
recover=load('Fluox+Donepezil_tadpoles072721_recover_MvmntIDX.mat');
%divide the time in 5 min bins
time_stasis=stasis.time(1):3:stasis.time(end);
[N,EDGES] = histcounts(stasis.time,length(time_stasis));
color=jet(6);

figure
for i=1:6
    %stas_Imstd_smooth(i,:)=smooth(stasis.Imstd(i,:),stasis.v.FrameRate*60);
   stas_Imstd_smooth(i,:)=smooth(stasis.Imstd(i,:),10);

    plot(stasis.time,stas_Imstd_smooth(i,:),'Color',color(i,:))
    hold on
end
YL=ylim(gca);
figure
for i=1:6
    %recover_Imstd_smooth(i,:)=smooth(recover.Imstd{i},stasis.v.FrameRate*60);
        recover_Imstd_smooth(i,:)=smooth(recover.Imstd{i},10);

    plot(recover.time(1:342566),recover_Imstd_smooth(i,1:342566),'Color',color(i,:))
    hold on
end
ylim(YL)

for i=1:length(time_stasis)
    recover_bins{i}=[];
    groups{i}=[];
for j=1:6
    recover_bins{i}=[recover_bins{i},stas_Imstd_smooth(j,stasis.time>=EDGES(i)&stasis.time<EDGES(i+1))];
    groups{i}=[groups{i},j*ones(size(stas_Imstd_smooth(j,stasis.time>=EDGES(i)&stasis.time<EDGES(i+1))))];
end
end
for i=1:1%length(time_stasis)
    [P,ANOVATAB,STATS]=kruskalwallis(recover_bins{i},groups{i});
end