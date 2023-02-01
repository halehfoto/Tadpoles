%this is a program that pools data from different experiments with similar
%treatments.
clearvars
close all
path='\\files.med.harvard.edu\Wyss Institute\Levin Lab\Haleh\Biostasis paper';
cd(path)
path2=uigetdir;
cd(path2)
filenames_treatment={'092120_Donepezil_treatment_tadpoles090820_Trim.mp4_motion_tracking.mat',...
                     '092220_Donepezil50uM_tadpoles090820.avi_motion_tracking.mat',...
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
V{3}=Mov{3}{1};
V{4}=Mov{3}{3};

V_pool=NaN(4,a);
for i=1:4
    V_pool(i,1:length(V{i})-2)=movmean(V{i}(2:end-1)/V{i}(2),10);
end
xl=find(Rec_Time{b}>100,1);
% V_pool(xl+1:end)=[];
figure;plot(Rec_Time{b}(2:xl),movmean(nanmean(V_pool(:,2:xl)),5),'k')
hold on
plot(Rec_Time{b}(2:xl),movmean(nanmean(V_pool(:,2:xl)),5)+movmean(nanstd(V_pool(:,2:xl)),5),'k:')
plot(Rec_Time{b}(2:xl),movmean(nanmean(V_pool(:,2:xl)),5)-movmean(nanstd(V_pool(:,2:xl)),5),'k:')

hold on
WC22{1}=Mov{1}{2};
WC22{2}=Mov{1}{3};
WC22{3}=Mov{2}{2};
WC22{4}=Mov{3}{4};
for i=1:4
    WC22_baseline(i)=WC22{i}(2);
end
WC22_Treat_pool=NaN(4,a);
for i=1:4
    WC22_Treat_pool(i,1:length(WC22{i})-2)=movmean(WC22{i}(2:end-1)/WC22{i}(2),10);
end
WC22_Treat_pool(:,xl+1:end)=[];
plot(Rec_Time{b}(2:xl),movmean(nanmean(WC22_Treat_pool(:,2:end)),5),'r')
hold on
plot(Rec_Time{b}(2:xl),movmean(nanmean(WC22_Treat_pool(:,2:end)),5)+movmean(nanstd(WC22_Treat_pool(:,2:end)),5),'r:')
plot(Rec_Time{b}(2:xl),movmean(nanmean(WC22_Treat_pool(:,2:end)),5)-movmean(nanstd(WC22_Treat_pool(:,2:end)),5),'r:')
% xlim([0,100])
xlabel('Time (min)')
save('WC22_Treatment_data.mat')
%% do the same thing for recovery
%clearvars
clear Mov
clear D
clear interval
clear framerate
clear Rec_Length
clear Rec_Time
clear V
clear V_pool

filenames_recovery={'092120_revovery_post_donepezil_kestose50uM_tadpoles090820_Trim.mp4_motion_tracking.mat',...
                    '092220_Kestose50mMRecovery_post50uMDonepezil_tadpoles090820.avi_motion_tracking.mat',...
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
V{3}=Mov{3}{1};

V_pool=NaN(3,a);
for i=1:3
    V_pool(i,1:length(V{i})-2)=movmean(V{i}(2:end-1)/V{i}(2),10);
end

plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(V_pool(:,2:end-1)),5),'b')
hold on
plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(V_pool(:,2:end-1)),5)+movmean(nanstd(V_pool(:,2:end-1)),5),'b:')
plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(V_pool(:,2:end-1)),5)-movmean(nanstd(V_pool(:,2:end-1)),5),'b:')

hold on
WC22{1}=Mov{1}{2}/WC22_baseline(1);
WC22{2}=Mov{2}{2}/WC22_baseline(3);
WC22{3}=Mov{3}{2}/WC22_baseline(4);

WC22_rec_pool=NaN(3,a);
for i=1:3
    WC22_rec_pool(i,1:length(WC22{i})-2)=movmean(WC22{i}(2:end-1),10);
end
plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(WC22_rec_pool(:,2:end-1)),5),'r')
hold on
plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(WC22_rec_pool(:,2:end-1)),5)+movmean(nanstd(WC22_rec_pool(:,2:end-1)),5),'r:')
plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(WC22_rec_pool(:,2:end-1)),5)-movmean(nanstd(WC22_rec_pool(:,2:end-1)),5),'r:')
xlim([0,350])
ylabel('Normalized Movement Index')         
save('WC22_Recovery_data.mat')
