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

filenames_treatment={'020421_EAAT_TFBTBOA200uM_UPC101200uM_tadpoles012621_start1111a.avi_motion_tracking.mat',...
                                '020921_tadpoles012621_UPCH200uM_dronedarone40uM.avi_motion_tracking.mat', ...
                                '110220_SNC80+KBR7943_DLTOBA500uM_tadpoles102020.avi_motion_tracking.mat', ...
                                '02162021_EAATs.mp4_motion_tracking.mat'};

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
%V{1}=Mov{1}{1};%dropped none swimming vehicle
V{1}=Mov{2}{1};
V{2}=Mov{3}{1};
V{3}=Mov{4}{1};
V_pool=NaN(3,a);
for i=1:3
    V_pool(i,1:length(V{i})-2)=V{i}(2:end-1)/V{i}(2);
end
x=find(Rec_Time{b}>120,1);
x=a
figure;plot(Rec_Time{b}(2:x),movmean(nanmean(V_pool(:,2:x)),10),'k')
hold on
plot(Rec_Time{b}(2:x),movmean(nanmean(V_pool(:,2:x)),10)+movmean(nanstd(V_pool(:,2:x)),10),'k:')
plot(Rec_Time{b}(2:x),movmean(nanmean(V_pool(:,2:x)),10)-movmean(nanstd(V_pool(:,2:x)),10),'k:')

hold on
TFB_TBOA_200uM=Mov{1}{2};

UPCH_100uM=Mov{2}{3};
DLTBOA_500uM=Mov{3}{2};
DLTBOA_300uM=Mov{4}{2};
UPCH_50uM=Mov{4}{5};
UPCH_150uM=Mov{4}{6};

xl=min(x,length(TFB_TBOA_200uM)-1);
MM=movmean(TFB_TBOA_200uM(2:xl),10);
plot(Rec_Time{b}(2:xl),MM/MM(1),'r-')
hold on

% xl=min(x,length(UPCH_150uM)-1);
% plot(Rec_Time{b}(2:xl),movmean(UPCH_150uM(:,2:xl)/UPCH_150uM(2),10),'b.-')
xl=min(length(UPCH_100uM)-1,x);
MM=movmean(UPCH_100uM(2:xl),10);
plot(Rec_Time{b}(2:xl),MM/MM(1),'b')
% xl=min(length(UPCH_50uM)-1,x);
% plot(Rec_Time{b}(2:xl),movmean(UPCH_50uM(:,2:xl)/UPCH_50uM(2),10),'b')

xl=min(length(DLTBOA_500uM)-1,x);
MM=movmean(DLTBOA_500uM(:,2:xl),10);
plot(Rec_Time{b}(2:xl),MM/MM(1),'m')
% xl=min(length(DLTBOA_300uM)-1,x);
% plot(Rec_Time{b}(2:xl),movmean(DLTBOA_300uM(:,2:xl)/DLTBOA_300uM(2),10),'m')


xlim([0,1400])
xlabel('Time (min)')
ylabel('Normalized Movement Index')