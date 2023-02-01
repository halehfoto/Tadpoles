%This is to plot habituation rate for different conditions, this code works
%for only the case where there is a common treatment time for all drugs.

clearvars
close all
path=uigetdir;
cd(path)
filenames_Train=dir(strcat('*_Group*_Train_analyzed.mat'));
filenames_Test=dir(strcat('*_Group*_Test_analyzed.mat'));



%% analyze Training
Resp_Train=[];
for i=1:length(filenames_Train)
    d=load(filenames_Train(i).name);
    Resp_Train=[Resp_Train;d.Resp(:,1:450)];
end
Resp_Test=[];
for i=1:length(filenames_Test)
    d=load(filenames_Test(i).name);
    if length(d.Resp)<150
        temp=[d.Resp,NaN(size(d.Resp,1),150-size(d.Resp,2))];
    else
        temp=d.Resp(:,1:150);
    end
    Resp_Test=[Resp_Test;temp];
end
figure
title('training')
for i=1:1
    
    resp_prob(i,:)=nanmean(Resp_Train(:,(50*(i-1)+1:50*i)),1);
    plot((50*(i-1)+1:1:50*i),resp_prob(i,:),'k*');hold on
    f=fit(((50*(i-1)+1:1:50*i))',(resp_prob(i,:))','exp1');plot(f,((50*(i-1)+1:1:50*i))',(resp_prob(i,:))')
end
legend off


%% analyze Testing
title('Testing')
for i=3:5
    j=i-2;
    resp_prob(i,:)=nanmean(Resp_Test(:,(50*(j-1)+1:50*j)),1);
    plot((50*(i-1)+1:1:50*i),resp_prob(i,:),'k*');hold on
    f=fit(((50*(i-1)+1:1:50*i))',(resp_prob(i,:))','exp1');plot(f,((50*(i-1)+1:1:50*i))',(resp_prob(i,:))')
end
legend off


