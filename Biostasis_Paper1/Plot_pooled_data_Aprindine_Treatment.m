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

filenames_treatment={'SNC80_100uM_100520_tadpoles092220_treatment2h.avi_motion_tracking.mat',...
                     'TreatmentWC1+WC22_WIN_20210426_09_48_52_Pro.mp4_motion_tracking.mat'};
                 
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
V{1}=Mov{1}{1};
V{2}=Mov{2}{1};
V{3}=Mov{2}{3};
V_pool=NaN(3,a);
for i=1:3
    V_pool(i,1:length(V{i})-2)=V{i}(2:end-1);
end
xl=find(Rec_Time{b}>100,1);
figure;plot(Rec_Time{b}(2:xl),movmean(nanmean(V_pool(:,2:xl)),5),'b')
hold on
plot(Rec_Time{b}(2:xl),movmean(nanmean(V_pool(:,2:xl)),5)+movmean(nanstd(V_pool(:,2:xl)),5),'b:')
plot(Rec_Time{b}(2:xl),movmean(nanmean(V_pool(:,2:xl)),5)-movmean(nanstd(V_pool(:,2:xl)),5),'b:')

hold on
WC1{1}=Mov{1}{2};
WC1{2}=Mov{1}{3};
WC1{3}=Mov{2}{2};
WC1_Treat_pool=NaN(3,a);
for i=1:3
    WC1_Treat_pool(i,1:length(WC1{i})-2)=WC1{i}(2:end-1);
end

plot(Rec_Time{b}(2:xl),movmean(nanmean(WC1_Treat_pool(:,2:xl)),5),'r')
hold on
plot(Rec_Time{b}(2:xl),movmean(nanmean(WC1_Treat_pool(:,2:xl)),5)+movmean(nanstd(WC1_Treat_pool(:,2:xl)),5),'r:')
plot(Rec_Time{b}(2:xl),movmean(nanmean(WC1_Treat_pool(:,2:xl)),5)-movmean(nanstd(WC1_Treat_pool(:,2:xl)),5),'r:')
% xlim([0,100])
xlabel('Time (min)')

%% do the same thing for recovery
clearvars
filenames_recovery={ 'SNC80_100uM_Recovery_KestoseVsMMR_100520_tadpoles092220.avi_motion_tracking.mat',...
                    'RecoveryWC1+WC22_WIN_20210426_12_18_11_Pro.mp4_motion_tracking.mat'};
                
 for i=1:length(filenames_recovery)
    d=load(filenames_recovery{i});
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
V{1}=Mov{1}{1};
V{2}=Mov{2}{1};
V{3}=Mov{2}{3};

V_pool=NaN(3,a);
for i=1:3
    V_pool(i,1:length(V{i})-2)=V{i}(2:end-1);
end

plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(V_pool(:,2:end-1)),5),'k')
hold on
plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(V_pool(:,2:end-1)),5)+movmean(nanstd(V_pool(:,2:end-1)),5),'k:')
plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(V_pool(:,2:end-1)),5)-movmean(nanstd(V_pool(:,2:end-1)),5),'k:')

hold on
WC1{1}=Mov{1}{2};
WC1{2}=Mov{2}{2};

WC1_Treat_pool=NaN(2,a);
for i=1:2
    WC1_Treat_pool(i,1:length(WC1{i})-2)=WC1{i}(2:end-1);
end
plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(WC1_Treat_pool(:,2:end-1)),5),'r')
hold on
plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(WC1_Treat_pool(:,2:end-1)),5)+movmean(nanstd(WC1_Treat_pool(:,2:end-1)),5),'r:')
plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(WC1_Treat_pool(:,2:end-1)),5)-movmean(nanstd(WC1_Treat_pool(:,2:end-1)),5),'r:')
xlim([0,300])
               