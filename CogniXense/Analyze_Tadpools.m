%this is a program that reads the output of the tracking program: decision
%accuracy and windowed motion trail generated by the tadpole_pipeline,
%choose the csvs folder
%make sure to change the time window to 10 min in the python folder
clearvars
%close all
cd('C:\Users\Haleh\OneDrive - Harvard University\Documents\Tadpole Data\Cognixense\Haleh')
path=uigetdir;
cd(path)
Dec=readtable('decision_accuracy.csv','FileType','Spreadsheet');
motion=readtable('windowed_motion.csv','FileType','Spreadsheet');
exp_end=readtable('Experiment_Duration.csv','FileType','Spreadsheet');
data=load('innate_pref.mat');
ip=data.Dec_test_p
groups=unique(exp_end{:,2});
ngroups=length(groups);
ncond=input('please enter the number of conditions:');
tadpools=cellstr(table2cell(motion(:,2)));
%calculate the number of pools in each group
for i=1:ngroups
    npools(i)=sum(strncmp(cell2mat(groups(i)),tadpools,7));
end
sensor_data=csvread('Sensor_visits.csv',1,2);
sensor_data(sensor_data==0)=NaN;
Dec_train_p=Dec{1:4:end,4:end};%correct probability during training
Dec_train_p(Dec_train_p==0)=NaN;
Dec_train_n=Dec{2:4:end,4:end};%number of decisions during training
Dec_train_n(Dec_train_n==0)=NaN;
Dec_test_p=Dec{3:4:end,4:end};%correct probability during testing
Dec_test_p(Dec_test_p==0)=NaN;
Dec_test_n=Dec{4:4:end,4:end};
Dec_test_n(Dec_test_n==0)=NaN;%number of decisions during testing
motion_tadpole=motion{1:end,3:end};
for i=1:size(exp_end,1)
    time{i}=10:10:exp_end{i,3}/60;
end
for i=1:size(motion_tadpole,1)
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
%for each group plot the decision data
for i=1:ngroups
    if i<=(ngroups/ncond)
        color{i}='g';
    elseif i>(ngroups/ncond)& i<=2*(ngroups/ncond)
        color{i}='b';
    else
        color{i}='r';
    end
end
figure
cnt=0;
for k=1:ngroups
    for i=1+cnt:npools(k)+cnt
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
        if ~isempty(dts) & length(dts)<2
            dts(2)=NaN;
        elseif isempty(dts)
            dts=[NaN,NaN];
        end

        subplot(2,1,1)
        if k<=(ngroups/ncond)
            plot([1,2,3],[nanmean(ip(i,:)),nanmean(dtr),nanmean(dts)],'LineStyle','none','Marker','o','Color',color{k})
        elseif k>(ngroups/ncond)& k<=2*(ngroups/ncond)
            plot([1.25,2.25,3.25],[nanmean(ip(i,:)),nanmean(dtr),nanmean(dts)],'LineStyle','none','Marker','o','Color',color{k})
        else
            plot([1.5,2.5,3.5],[nanmean(ip(i,:)),nanmean(dtr),nanmean(dts)],'LineStyle','none','Marker','o','Color',color{k})
        end            
        hold on
        xlabel('state');
        ylabel('decision accuracy')
%         subplot(3,1,3)
%         plot([0.4,1.4],[decision_train_sum(i),decision_test_sum(i)],'Color',color{k},'Marker','o')
%         hold on
%         ylabel('Sum of all decisions')
        dtr1{k}(i-cnt)=dtr(1);
        dts1{k}(i-cnt)=dts(1);
        ip1{k}(i-cnt)=ip(i,1);
    end
    subplot(2,1,2)
    histogram(motion_sum(1+cnt:npools(k)+cnt),10,'FaceColor',color{k},'FaceAlpha',0.5,'Normalization','Probability')
    hold on
    ylabel('Sum of all sensor Xings')

    cnt=cnt+npools(k);
end

figure;plot(Dec_train_p,decision_train_sum,'o')
xlabel('accuracy')
ylabel('decision sum')
corrcoef(motion_sum,decision_test_sum)


% save('innate_pref.mat','Dec_test_p')
n=ngroups;
figure;
cnt=0;
for k=1:ngroups
    subplot(n,1,k)
    all_sensor_data=reshape(sensor_data(1+cnt:npools(k)+cnt,:),[1,numel(sensor_data(1+cnt:npools(k)+cnt,:))]);
    min(all_sensor_data)
    histogram(all_sensor_data)
    cnt=cnt+npools(k);
end


figure;
cnt=0;
for k=1:ngroups
    plot(nanmedian(motion_tadpole(1+cnt:npools(k)+cnt,:)),'Color',color{k})
    hold on;
    cnt=cnt+npools(k);
end
%compare decision accuracies
trdata=[];
tsdata=[];
groupstr=[];
groupsts=[];
for i=1:ngroups
    trdata=[trdata,dtr1{i}];
    tsdata=[tsdata,dts1{i}];
    groupstr=[groupstr,i*ones(size(dtr1{i}))];
    groupsts=[groupsts,i*ones(size(dts1{i}))];
end
kruskalwallis(trdata,groupstr)
kruskalwallis(tsdata,groupsts)
allTrTs=[dtr1{2},dtr1{3},dts1{2},dts1{3}];
groups=[ones(size(dtr1{2})),ones(size(dtr1{3})),2*ones(size(dts1{2})),2*ones(size(dts1{3}))]

BigTrTs=[dtr1{3},dts1{3}];
groups=[ones(size(dtr1{3})),2*ones(size(dts1{3}))]
kruskalwallis(BigTrTs,groups)

smallTrTs=[dtr1{2},dts1{2}];
groups=[ones(size(dtr1{2})),2*ones(size(dts1{2}))]
kruskalwallis(smallTrTs,groups)

kruskalwallis(allTrTs,groups)
allTrTsC=[dtr1{1},dts1{1}]
groups=[ones(size(dtr1{1})),2*ones(size(dts1{1}))]
kruskalwallis(allTrTsC,groups)


%compare train, test, ip for all three groups
control=[ip1{1},dtr1{1},dts1{1}];
groupsc= [ones(size(ip1{1})),2*ones(size(dtr1{1})),3*ones(size(dts1{1}))];
kruskalwallis(control, groupsc)

small=[ip1{2},dtr1{2},dts1{2}];
groupss= [ones(size(ip1{2})),2*ones(size(dtr1{2})),3*ones(size(dts1{2}))];
kruskalwallis(small, groupss)

large=[ip1{3},dtr1{3},dts1{3}];
groupsl= [ones(size(ip1{3})),2*ones(size(dtr1{3})),3*ones(size(dts1{3}))];
kruskalwallis(large, groupsl)

all=[control,small,large];
groups=[groupsc,groupss+3,groupsl+6]
kruskalwallis(all,groups)