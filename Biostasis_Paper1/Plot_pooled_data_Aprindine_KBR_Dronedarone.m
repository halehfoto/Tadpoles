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

filenames_treatment={'020921_tadpoles012621_UPCH200uM_dronedarone40uM.avi_motion_tracking.mat',...
                                'KB-R7943_treat102220_tadpoleslot101320_Trim.mp4_motion_tracking.mat', ...
                                'KB-R7943_10uM+5uMtreatment_102320_tadpoles101320.avi_motion_tracking.mat', ...
                                'Apindine10uM+25uM_tadpoles12012020.mp4_motion_tracking.mat'};

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
vehicle_base=V{2}(2);
V{3}=Mov{3}{1};
V{4}=Mov{4}{1};
V_pool=NaN(4,a);
for i=1:4
    V_pool(i,1:length(V{i})-2)=V{i}(2:end-1)/V{i}(2);
end
x=find(Rec_Time{b}>120,1);
figure;plot(Rec_Time{b}(2:x),movmean(nanmean(V_pool(:,2:x)),10),'k')
hold on
plot(Rec_Time{b}(2:x),movmean(nanmean(V_pool(:,2:x)),10)+movmean(nanstd(V_pool(:,2:x)),10),'k:')
plot(Rec_Time{b}(2:x),movmean(nanmean(V_pool(:,2:x)),10)-movmean(nanstd(V_pool(:,2:x)),10),'k:')

hold on
Dronedarone_40uM=Mov{1}{2};
KBR_100uM=Mov{2}{2};
KBR_500uM=Mov{2}{3};
KBR_10uM=Mov{3}{2};
KBR_5uM=Mov{3}{3};
Aprindine_10uM=Mov{4}{2};
Aprindine_25uM=Mov{4}{3};

xl=min(x,length(Dronedarone_40uM)-1);
MM=movmean(Dronedarone_40uM(2:xl),10);
plot(Rec_Time{b}(2:xl),MM/MM(1),'r*-')
hold on
xl=min(length(KBR_500uM)-1,120);
MM=movmean(KBR_500uM(:,2:xl),10);
KBR500_base=MM(1);
plot(Rec_Time{b}(2:xl),MM/MM(1),'b*-')

xl=min(length(KBR_100uM)-1,120);
MM=movmean(KBR_100uM(2:xl),10);
KBR100_base=MM(1);
plot(Rec_Time{b}(2:xl),MM/MM(1),'b.-')

xl=min(length(KBR_10uM)-1,120);
MM=movmean(KBR_10uM(:,2:xl),10);
plot(Rec_Time{b}(2:xl),MM/MM(1),'b','LineWidth',1.5)

xl=min(length(KBR_5uM)-1,120);
MM=movmean(KBR_5uM(:,2:xl),10);
plot(Rec_Time{b}(2:xl),MM/MM(1),'b')

xl=min(length(Aprindine_10uM)-1,120);
MM=movmean(Aprindine_10uM(:,2:xl),10);
plot(Rec_Time{b}(2:xl),MM/MM(1),'m*-')

xl=min(length(Aprindine_25uM)-1,120);
MM=movmean(Aprindine_25uM(:,2:xl),10);
plot(Rec_Time{b}(2:xl),MM/MM(1),'m.-')


%xlim([0,120])
xlabel('Time (min)')

%% do the same thing for recovery
%clearvars
clear Mov
clear V
clear D
clear interval
clear framerate
clear Rec_Time
clear Rec_Length

filenames_recovery={ 'KB-R793_Recovery102220_tadpoles101320.avi_motion_tracking.mat'};
                
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
VR=Mov{1}{1};
VR=VR/vehicle_base;
plot(130+Rec_Time{b}(2:end-1),movmean(VR(2:end-1),10),'k')
hold on
KBR_500uM=Mov{1}{3}/KBR500_base;
KBR_100uM=Mov{1}{2}/KBR100_base;
plot(130+Rec_Time{b}(2:end-1),movmean(KBR_500uM(2:end-1),10),'b*-')
plot(130+Rec_Time{b}(2:end-1),movmean(KBR_100uM(2:end-1),10),'b.-')

xlim([0,200])
ylabel('Normalized Movement Index')               