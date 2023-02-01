%this is a program that takes recovery and treatment data and plots the
%normalized plot
clearvars
close all
path2=uigetdir;
cd(path2)
%taking out  'NTI+SNC80.mp4_motion_tracking.mat' because of movement
%taking the 'SNC80100uM+NTI150uM.mp4_motion_tracking.mat' vehicle out, it
%is acting strange

d_t=load('20220722_14_11_13_25uM-Cis22a_25uM-BCTC_treatment-1h.mp4_motion_tracking.mat');
d_r=load('20220722_15_20_06_25uM-Cis22a_25uM-BCTC_recovery.mp4_motion_tracking.mat');
figure
for i=1:d_r.numwells
   % Y=smooth(Imstd{i}(1:nFrames-1),200)/max(smooth(Imstd{i}(1:nFrames-1),200));
    %plot(time(1:end-200),Y(1:end-200),'Color',color(i,:),'LineWidth',1)
%     figure(5)
    smooth_plot_r{i}=movmean(downsample(d_r.Imstd{i}(2:end-1),3),10);
    smooth_plot_t{i}=movmean(downsample(d_t.Imstd{i}(2:end-1),3),10);
% figure(1)
     plot(downsample(d_t.time(2:end-1),3),smooth_plot_t{i}/smooth_plot_t{i}(1),'Color',d_r.color(i,:),'LineWidth',2)
     hold on
%     figure(2)
%     plot(smooth_plot_r{i}(21:end))
  %  plot(time(2:end),(Imstd{i}(2:end-1))/(Imstd{i}(2)),'Color',color(i,:),'LineWidth',0.1)
%     plot(d_t.time(2:end-1),smooth_plot_t{i},'Color',d_r.color(i,:),'LineWidth',2)

    hold on
   plot(100+downsample(d_r.time(2:end-1),3),smooth_plot_r{i}/smooth_plot_t{i}(1),'Color',d_r.color(i,:),'LineWidth',2)
    smooth_plot_r{i}=smooth_plot_r{i}/smooth_plot_t{i}(1);
    smooth_plot_t{i}=smooth_plot_t{i}/smooth_plot_t{i}(1);
%     if i~=1 & i~=3
%         for j=1:length(Immean{i}(2:end-1))
%             if ztest(Immean{i}(1+j),Cont_mean,Cont_std)<1
%                 plot(time(1+j),100*Immean{i}(1+j),'*','Color',color(i,:))
%                 hold on
%             end
%         end
%     end
%     figure(6)
%     plot(time(2:end-1),1000*Immean{i}(2:end-1),'Color','k','LineWidth',1)
%     hold on
    xlabel('Time (min)') 
    ylabel('Movement Index')
%     ylim([0.7,1])
end

save('WC1_Treatment_Recovery_0.5minres.mat')
% [a,b]=max(Rec_Length);
% hold on
% WC1{1}=Mov{1}{2};
% WC1_baseline1=WC1{1}(2);
% WC1{2}=Mov{1}{3};
% WC1_baseline2=WC1{2}(2);
% WC1{3}=Mov{2}{2};
% WC1_Treat_pool=NaN(3,a);
% for i=1:3
%     WC1_Treat_pool(i,1:length(WC1{i})-2)=WC1{i}(2:end-1)/WC1{i}(2);
% end
% 
% plot(Rec_Time{b}(2:xl),movmean(nanmean(WC1_Treat_pool(:,2:xl)),10),'r')
% hold on
% plot(Rec_Time{b}(2:xl),movmean(nanmean(WC1_Treat_pool(:,2:xl)),10)+movmean(nanstd(WC1_Treat_pool(:,2:xl)),10),'r:')
% plot(Rec_Time{b}(2:xl),movmean(nanmean(WC1_Treat_pool(:,2:xl)),10)-movmean(nanstd(WC1_Treat_pool(:,2:xl)),10),'r:')
% % xlim([0,100])
% xlabel('Time (min)')
% 
% %% do the same thing for recovery
% clear Mov
% clear D
% clear interval
% clear framerate
% clear Rec_Length
% clear Rec_Time
% clear V
% clear V_pool
% filenames_recovery={ 'SNC80_100uM_Recovery_KestoseVsMMR_100520_tadpoles092220.avi_motion_tracking.mat',...
%                     'RecoveryWC1+WC22_WIN_20210426_12_18_11_Pro.mp4_motion_tracking.mat'};
%                 
%  for i=1:length(filenames_recovery)
%     d=load(filenames_recovery{i});
%     Mov{i}=d.Imstd;
%     D{i}=d.Drugs;
%     interval(i)=d.m;
%     framerate(i)=d.fps;
%     Rec_Length(i)=length(d.Imstd{1});
%     Rec_Time{i}=d.time;
%     clear d
% end
% [a,b]=max(Rec_Length);
% %pool all vehicle;
% V{1}=Mov{1}{1};
% V{2}=Mov{2}{1};
% V{3}=Mov{2}{3};
% 
% V_pool=NaN(3,a);
% for i=1:3
%     V_pool(i,1:length(V{i})-2)=V{i}(2:end-1)/V{i}(2);
% end
% 
% plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(V_pool(:,2:end-1)),10),'k')
% hold on
% plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(V_pool(:,2:end-1)),10)+movmean(nanstd(V_pool(:,2:end-1)),10),'k:')
% plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(V_pool(:,2:end-1)),10)-movmean(nanstd(V_pool(:,2:end-1)),10),'k:')
% 
% hold on
% WC1{1}=Mov{1}{2}/WC1_baseline1;
% WC1{2}=Mov{2}{2}/WC1_baseline2;
% 
% WC1_Treat_pool=NaN(2,a);
% for i=1:2
%     WC1_Treat_pool(i,1:length(WC1{i})-2)=WC1{i}(2:end-1);
% end
% plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(WC1_Treat_pool(:,2:end-1)),10),'r')
% hold on
% plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(WC1_Treat_pool(:,2:end-1)),10)+movmean(nanstd(WC1_Treat_pool(:,2:end-1)),10),'r:')
% plot(110+Rec_Time{b}(2:end-1),movmean(nanmean(WC1_Treat_pool(:,2:end-1)),10)-movmean(nanstd(WC1_Treat_pool(:,2:end-1)),10),'r:')
% xlim([0,300])
% ylabel('Normalized Movement Index')                              