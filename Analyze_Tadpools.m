%this is a program that reads the output of the tracking program: decision
%accuracy and windowed motion trail generated by the tadpole_pipeline,
%choose the csvs folder
clearvars
%close all
cd('C:\Users\Haleh\OneDrive - Harvard University\Documents\Tadpole Data\Cognixense\Haleh')
path=uigetdir;
cd(path)
Dec=readtable('decision_accuracy.csv','FileType','Spreadsheet');
motion=readtable('windowed_motion.csv','FileType','Spreadsheet');
exp_end=readtable('Experiment_Duration.csv','FileType','Spreadsheet');
data=load('innate_pref.mat');
ip=data.Dec_test_p;
% tic
% sensor_data=readtable('Sensor_visits.csv','FileType','spreadsheet');
% toc
sensor_data=csvread('Sensor_visits.csv',1,2);
sensor_data(sensor_data==0)=NaN;
Dec_train_p=Dec{1:4:end,4:end};
Dec_train_p(Dec_train_p==0)=NaN;
Dec_train_n=Dec{2:4:end,4:end};
Dec_train_n(Dec_train_n==0)=NaN;
Dec_test_p=Dec{3:4:end,4:end};
Dec_test_p(Dec_test_p==0)=NaN;
Dec_test_n=Dec{4:4:end,4:end};
Dec_test_n(Dec_test_n==0)=NaN;
motion_tadpole=motion{1:end,3:end};
for i=1:size(exp_end,1)
    time{i}=10:10:exp_end{i,3}/60;
end
for i=1:size(motion,1)
%     figure;
%     hold on
%     title('Training data')
%     subplot(1,2,1)
%     hold on
%     plot(Dec_train_p(i,:),Dec_train_n(i,:),'o')
%     xlabel('accuracy during 20 min training windows');
%     ylabel('number of decisions made during that window')
%     subplot(1,2,2)
%     hold on
%     plot(time{i},motion_tadpole(i,1:length(time{i})))
%     xlabel('time (min)')
%     ylabel('total number of sensor switches in 10 min bins')
%     ylim([0,600])
%     subplot(1,3,3)
%     hold on
%     hist(sensor_data(i,:),6)
%     xlim([1,6])
    motion_sum(i)=nansum(motion_tadpole(i,1:length(time{i})));
    decision_train_sum(i)=nansum(Dec_train_n(i,:));
end
for i=1:size(motion,1)
%     figure;
%     hold on
%     title('Testing data')
%     subplot(1,2,1)
%     hold on
%     plot(Dec_test_p(i,:),Dec_test_n(i,:),'o')
%     xlabel('accuracy during 20 min training windows');
%     ylabel('number of decisions made during that window')
%     subplot(1,2,2)
%     hold on
%     plot(time{i},motion_tadpole(i,1:length(time{i})))
%     xlabel('time (min)')
%     ylabel('total number of sensory switches in 10 min bins')
% %     ylim([0,600])
%     subplot(1,3,3)
%     hold on
%     hist(sensor_data(i,:),6)
%     xlim([1,6])
    motion_sum(i)=nansum(motion_tadpole(i,1:length(time{i})));
    decision_test_sum(i)=nansum(Dec_test_n(i,:));
end
figure
if ~exist('ip')
    ip=NaN(size(motion,1),1);
end
for i=1:size(motion,1)/2
    dtr=Dec_train_p(i,~isnan(Dec_train_p(i,:)));
    dts=Dec_test_p(i,~isnan(Dec_test_p(i,:)));
    if ~isempty(dtr) & length(dtr)<2
        dtr(2)=NaN;
    elseif isempty(dtr)
        dtr=[NaN,NaN];
    end
    if isempty(dts)
        dts=NaN;
    end
    subplot(3,1,1)
    plot([ip(i);dtr(1);dtr(end);dts(1)],'g-o')
    hold on
    xlabel('state');
    ylabel('decision accuracy')
    subplot(3,1,2)
    plot(motion_sum(i),'go')
    hold on
    ylabel('Sum of all sensor Xings')

    subplot(3,1,3)
    plot(decision_train_sum(i),'go')
    hold on
    ylabel('Sum of all decisions')
end
for i=1+size(motion,1)/2:size(motion,1)
    dtr=Dec_train_p(i,~isnan(Dec_train_p(i,:)));
    dts=Dec_test_p(i,~isnan(Dec_test_p(i,:)));
    if ~isempty(dtr) & length(dtr)<2
        dtr(2)=NaN;
    elseif isempty(dtr)
        dtr=[NaN,NaN];
    end
    if isempty(dts)
        dts=NaN;
    end
    subplot(3,1,1)
    plot([ip(i);dtr(1);dtr(end);dts(1)],'r-o')
    hold on
    subplot(3,1,2)
    plot(motion_sum(i),'ro')
    hold on
    subplot(3,1,3)
    plot(decision_train_sum(i),'ro')
    hold on

end

figure;plot(Dec_train_p,decision_train_sum,'o')
xlabel('accuracy')
ylabel('decision sum')
corrcoef(motion_sum,decision_test_sum)


save('innate_pref.mat','Dec_test_p')

figure;
subplot(2,1,1)
all_sensor_data=reshape(sensor_data(1:10,:),[1,numel(sensor_data)/2]);
min(all_sensor_data)
histogram(all_sensor_data)

figure;
subplot(2,1,2)
all_sensor_data=reshape(sensor_data(11:20,:),[1,numel(sensor_data)/2]);
min(all_sensor_data)
histogram(all_sensor_data)

X1=reshape(sensor_data(1:10,:),[1,numel(sensor_data)/2]);
X2=reshape(sensor_data(11:20,:),[1,numel(sensor_data)/2]);
dfittool(X1)
dfittool(X2)

figure;plot(nanmedian(motion_tadpole(1:10,:)),'g')
hold on
plot(nanmedian(motion_tadpole(11:20,:)),'r')

%ADD motion data for each sensor
md=