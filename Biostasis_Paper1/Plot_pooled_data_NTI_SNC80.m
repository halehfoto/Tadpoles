%this is a program that pools data from different experiments with similar
%treatments.
clearvars
close all
path='\\files.med.harvard.edu\Wyss Institute\Levin Lab\Haleh\Biostasis paper';
cd(path)
path2=uigetdir;
cd(path2)
%taking out  'NTI+SNC80.mp4_motion_tracking.mat' because of movement
%taking the 'SNC80100uM+NTI150uM.mp4_motion_tracking.mat' vehicle out, it
%is acting strange

filenames_treatment={'SNC80100uM+NTI150uM.mp4_motion_tracking.mat', 'NTI+SNC80.mp4_motion_tracking.mat'};

for i=1:length(filenames_treatment)
    d=load(filenames_treatment{i});
    Mov{i}=d.Imstd;
    D{i}=d.Drugs;
    interval(i)=d.m;
    framerate(i)=d.fps;
    Rec_Length(i)=length(d.Imstd{1});
    Rec_Time{i}=d.time;
    clear d
end
[a,b]=max(Rec_Length);
%pool all vehicle;
%V{1}=Mov{1}{1};
V{1}=Mov{2}{1};
x=length(V{1})-1;
MM=movmean(V{1}(2:x)/V{1}(2),10);
figure;plot(Rec_Time{b}(2:x),MM/MM(1),'k')
Vehicle=MM/MM(1);
hold on

SNC80_100uM=Mov{1}{2};
SNC80_100uM_NTI_150uM=Mov{1}{3};
NTI_150uM=Mov{1}{4};
SNC80=Mov{2}{2};
Naltrindone_SNC80=Mov{2}{3};

SNC80_pool=nan(2,max(length(SNC80_100uM),length(SNC80))-2);
SNC80_pool(1,1:length(SNC80_100uM)-2)=SNC80_100uM(2:end-1)/SNC80_100uM(2);
SNC80_pool(2,1:length(SNC80)-2)=SNC80(2:end-1)/SNC80(2);
Mean_SNC80_100uM=movmean(nanmean(SNC80_pool),10);
std_SNC80_100uM=movmean(nanstd(SNC80_pool),10);

xl=min(x,length(Mean_SNC80_100uM)+1);
plot(Rec_Time{b}(2:xl),Mean_SNC80_100uM(1:xl-1),'r')
hold on
plot(Rec_Time{b}(2:xl),Mean_SNC80_100uM(1:xl-1)+std_SNC80_100uM(1:xl-1),'r:')
plot(Rec_Time{b}(2:xl),Mean_SNC80_100uM(1:xl-1)-std_SNC80_100uM(1:xl-1),'r:')



NTI_SNC80_pool=nan(2,max(length(SNC80_100uM_NTI_150uM),length(Naltrindone_SNC80))-2);
NTI_SNC80_pool(1,1:length(SNC80_100uM_NTI_150uM)-2)=SNC80_100uM_NTI_150uM(2:end-1)/SNC80_100uM_NTI_150uM(2);
NTI_SNC80_pool(2,1:length(Naltrindone_SNC80)-2)=Naltrindone_SNC80(2:end-1)/Naltrindone_SNC80(2);
Mean_NTI_SNC80=movmean(nanmean(NTI_SNC80_pool),10);
std_NTI_SNC80=movmean(nanstd(NTI_SNC80_pool),10);

xl=min(x,length(Mean_NTI_SNC80)+1);
plot(Rec_Time{b}(2:xl),Mean_NTI_SNC80(1:xl-1),'m')
hold on
plot(Rec_Time{b}(2:xl),Mean_NTI_SNC80(1:xl-1)+std_NTI_SNC80(1:xl-1),'m:')
plot(Rec_Time{b}(2:xl),Mean_NTI_SNC80(1:xl-1)-std_NTI_SNC80(1:xl-1),'m:')



xlabel('Time (min)')
ylabel('Normalized Movement Index')
