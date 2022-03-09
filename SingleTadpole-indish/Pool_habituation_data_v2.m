%This is to plot habituation rate for different conditions
clearvars
close all
path=uigetdir;
cd(path)
filenames_Pre_C=dir('*C_Pre_analyzed.mat');
filenames_in_C=dir('*C_130in_analyzed.mat');
filenames_2h_C=dir('*C_2h_Post_analyzed.mat');
filenames_3h_C=dir('*C_3h_Post_analyzed.mat');

filenames_Pre_WC22=dir('*WC22_Pre_analyzed.mat');
filenames_in_WC22=dir('*WC22_130in_analyzed.mat');
filenames_2h_WC22=dir('*WC22_2h_Post_analyzed.mat');
filenames_3h_WC22=dir('*WC22_3h_Post_analyzed.mat');

filenames_Pre_WC1=dir('*WC1_Pre_analyzed.mat');
filenames_in_WC1=dir('*WC1_130in_analyzed.mat');
filenames_2h_WC1=dir('*WC1_2h_Post_analyzed.mat');
filenames_3h_WC1=dir('*WC1_3h_Post_analyzed.mat');

fn_baseline_in_C=dir('*C_130in_baseline_analyzed.mat');
fn_baseline_2h_C=dir('*C_2h_Post_baseline_analyzed.mat');

fn_baseline_in_WC22=dir('*WC22_130in_baseline_analyzed.mat');
fn_baseline_2h_WC22=dir('*WC22_2h_Post_baseline_analyzed.mat');

fn_baseline_in_WC1=dir('*WC1_130in_baseline_analyzed.mat');
fn_baseline_2h_WC1=dir('*WC1_2h_Post_baseline_analyzed.mat');

Resp_Pre_C=[];
for i=1:length(filenames_Pre_C)
    d=load(filenames_Pre_C(i).name);
    Resp_Pre_C=[Resp_Pre_C;d.Resp(:,1:20)];
end
Resp_in_C=[];
for i=1:length(filenames_in_C)
    d=load(filenames_in_C(i).name);
    Resp_in_C=[Resp_in_C;d.Resp(:,1:20)];
end
Resp_2h_C=[];
for i=1:length(filenames_2h_C)
    d=load(filenames_2h_C(i).name);
    Resp_2h_C=[Resp_2h_C;d.Resp(:,1:20)];
end
Resp_3h_C=[];
for i=1:length(filenames_3h_C)
    d=load(filenames_3h_C(i).name);
    Resp_3h_C=[Resp_3h_C;d.Resp(:,1:20)];
end


resp_prob_Pre_C=nanmean(Resp_Pre_C,1);
figure;title('Control'); plot(resp_prob_Pre_C,'*-');hold on
f=fit((1:1:20)',(resp_prob_Pre_C)','exp1');plot(f,(1:1:20)',(resp_prob_Pre_C)')

resp_prob_in_C=nanmean(Resp_in_C,1);

plot((21:1:40)',resp_prob_in_C,'*-');hold on
f=fit((21:1:40)',(resp_prob_in_C)','exp1');plot(f,(21:1:40)',(resp_prob_in_C)')

resp_prob_2h_C=nanmean(Resp_2h_C,1);
plot((41:1:60)',resp_prob_2h_C,'*-');hold on
f=fit((41:1:60)',(resp_prob_2h_C)','exp1');plot(f,(41:1:60)',(resp_prob_2h_C)')

resp_prob_3h_C=nanmean(Resp_3h_C,1);
plot((61:1:80)',resp_prob_3h_C,'*-');hold on
f=fit((61:1:80)',(resp_prob_3h_C)','exp1');plot(f,(61:1:80)',(resp_prob_3h_C)')

legend 'off'
ylim([0,1]);
%% do the same for WC22

figure

Resp_Pre_WC22=[];
for i=1:length(filenames_Pre_WC22)
    d=load(filenames_Pre_WC22(i).name);
    Resp_Pre_WC22=[Resp_Pre_WC22;d.Resp(:,1:20)];
end
Resp_in_WC22=[];
for i=1:length(filenames_in_WC22)
    d=load(filenames_in_WC22(i).name);
    Resp_in_WC22=[Resp_in_WC22;d.Resp(:,1:20)];
end
Resp_2h_WC22=[];
for i=1:length(filenames_2h_WC22)
    d=load(filenames_2h_WC22(i).name);
    Resp_2h_WC22=[Resp_2h_WC22;d.Resp(:,1:20)];
end
Resp_3h_WC22=[];
for i=1:length(filenames_3h_WC22)
    d=load(filenames_3h_WC22(i).name);
    Resp_3h_WC22=[Resp_3h_WC22;d.Resp(:,1:20)];
end
figure

resp_prob_Pre_WC22=nanmean(Resp_Pre_WC22,1);
figure;title('Control'); plot(resp_prob_Pre_WC22,'*-');hold on
f=fit((1:1:20)',(resp_prob_Pre_WC22)','exp1');plot(f,(1:1:20)',(resp_prob_Pre_WC22)')

resp_prob_in_WC22=nanmean(Resp_in_WC22,1);

plot((21:1:40)',resp_prob_in_WC22,'*-');hold on
f=fit((21:1:40)',(resp_prob_in_WC22)','exp1');plot(f,(21:1:40)',(resp_prob_in_WC22)')

resp_prob_2h_WC22=nanmean(Resp_2h_WC22,1);
plot((41:1:60)',resp_prob_2h_WC22,'*-');hold on
f=fit((41:1:60)',(resp_prob_2h_WC22)','exp1');plot(f,(41:1:60)',(resp_prob_2h_WC22)')

resp_prob_3h_WC22=nanmean(Resp_3h_WC22,1);
plot((61:1:80)',resp_prob_3h_WC22,'*-');hold on
f=fit((61:1:80)',(resp_prob_3h_WC22)','exp1');plot(f,(61:1:80)',(resp_prob_3h_WC22)')

legend 'off'
ylim([0,1]);

%% do the same for WC1

figure

Resp_Pre_WC1=[];
for i=1:length(filenames_Pre_WC1)
    d=load(filenames_Pre_WC1(i).name);
    Resp_Pre_WC1=[Resp_Pre_WC1;d.Resp(:,1:20)];
end
Resp_in_WC1=[];
for i=1:length(filenames_in_WC1)
    d=load(filenames_in_WC1(i).name);
    Resp_in_WC1=[Resp_in_WC1;d.Resp(:,1:20)];
end
Resp_2h_WC1=[];
for i=1:length(filenames_2h_WC1)
    d=load(filenames_2h_WC1(i).name);
    Resp_2h_WC1=[Resp_2h_WC1;d.Resp(:,1:20)];
end
Resp_3h_WC1=[];
for i=1:length(filenames_3h_WC1)
    d=load(filenames_3h_WC1(i).name);
    Resp_3h_WC1=[Resp_3h_WC1;d.Resp(:,1:20)];
end
figure

resp_prob_Pre_WC1=nanmean(Resp_Pre_WC1,1);
figure;title('Control'); plot(resp_prob_Pre_WC1,'*-');hold on
f=fit((1:1:20)',(resp_prob_Pre_WC1)','exp1');plot(f,(1:1:20)',(resp_prob_Pre_WC1)')

resp_prob_in_WC1=nanmean(Resp_in_WC1,1);

plot((21:1:40)',resp_prob_in_WC1,'*-');hold on
f=fit((21:1:40)',(resp_prob_in_WC1)','exp1');plot(f,(21:1:40)',(resp_prob_in_WC1)')

resp_prob_2h_WC1=nanmean(Resp_2h_WC1,1);
plot((41:1:60)',resp_prob_2h_WC1,'*-');hold on
f=fit((41:1:60)',(resp_prob_2h_WC1)','exp1');plot(f,(41:1:60)',(resp_prob_2h_WC1)')

resp_prob_3h_WC1=nanmean(Resp_3h_WC1,1);
plot((61:1:80)',resp_prob_3h_WC1,'*-');hold on
f=fit((61:1:80)',(resp_prob_3h_WC1)','exp1');plot(f,(61:1:80)',(resp_prob_3h_WC1)')

legend 'off'
ylim([0,1]);

%% compare baseline activities
thresh=0.5
nframes=38*60*5;

dm_in_C=[];
for i=1:length(fn_baseline_in_C)
    d=load(fn_baseline_in_C(i).name);
    dm_in_C=[dm_in_C;d.dm(:,1:nframes)];
end
%Median_dm_in_C=nanmedian(reshape(dm_in_C,[1,numel(dm_in_C)]));
for i=1:size(dm_in_C,1)
    index=find(dm_in_C(i,:)<thresh);
    dm_in_C(i,index)=0;
    dmsum_in_C(i)=nansum(dm_in_C(i,:));
end

dm_2h_C=[];
for i=1:length(fn_baseline_2h_C)
    d=load(fn_baseline_2h_C(i).name);
    dm_2h_C=[dm_2h_C;d.dm(:,1:nframes)];
end
%Median_dm_2h_C=nanmedian(reshape(dm_2h_C,[1,numel(dm_2h_C)]));
for i=1:size(dm_2h_C,1)
    index=find(dm_2h_C(i,:)<thresh);
    dm_2h_C(i,index)=0;
    dmsum_2h_C(i)=nansum(dm_2h_C(i,:));
end

%% do the same for WC22
dm_in_WC22=[];
for i=1:length(fn_baseline_in_WC22)
    d=load(fn_baseline_in_WC22(i).name);
    dm_in_WC22=[dm_in_WC22;d.dm(:,1:nframes)];
end
%Median_dm_in_WC22=nanmedian(reshape(dm_in_WC22,[1,numel(dm_in_WC22)]));
for i=1:size(dm_in_WC22,1)
    index=find(dm_in_WC22(i,:)<thresh);
    dm_in_WC22(i,index)=0;
    dmsum_in_WC22(i)=nansum(dm_in_WC22(i,:));
end

dm_2h_WC22=[];
for i=1:length(fn_baseline_2h_WC22)
    d=load(fn_baseline_2h_WC22(i).name);
    dm_2h_WC22=[dm_2h_WC22;d.dm(:,1:nframes)];
end
%Median_dm_2h_WC22=nanmedian(reshape(dm_2h_WC22,[1,numel(dm_2h_WC22)]));
for i=1:size(dm_2h_WC22,1)
    index=find(dm_2h_WC22(i,:)<thresh);
    dm_2h_WC22(i,index)=0;
    dmsum_2h_WC22(i)=sum(dm_2h_WC22(i,:));
end
%% do the same for WC1

dm_in_WC1=[];
for i=1:length(fn_baseline_in_WC1)
    d=load(fn_baseline_in_WC1(i).name);
    dm_in_WC1=[dm_in_WC1;d.dm(:,1:nframes)];
end
%Median_dm_in_WC1=nanmedian(reshape(dm_in_WC1,[1,numel(dm_in_WC1)]));
for i=1:size(dm_in_WC1,1)
    index=find(dm_in_WC1(i,:)<thresh);
    dm_in_WC1(i,index)=0;
    dmsum_in_WC1(i)=nansum(dm_in_WC1(i,:));
end

dm_2h_WC1=[];
for i=1:length(fn_baseline_2h_WC1)
    d=load(fn_baseline_2h_WC1(i).name);
    dm_2h_WC1=[dm_2h_WC1;d.dm(:,1:nframes)];
end
%Median_dm_2h_WC1=nanmedian(reshape(dm_2h_WC1,[1,numel(dm_2h_WC1)]));
for i=1:size(dm_2h_WC1,1)
    index=find(dm_2h_WC1(i,:)<thresh);
    dm_2h_WC1(i,index)=0;
    dmsum_2h_WC1(i)=nansum(dm_2h_WC1(i,:));
end
%%

All_dmsum=[dmsum_in_C,dmsum_2h_C,dmsum_in_WC1,dmsum_2h_WC22,dmsum_in_WC1,dmsum_2h_WC1];
All_dmsum_groups=[ones(size(dmsum_in_C)),2*ones(size(dmsum_2h_C)),3*ones(size(dmsum_in_WC22)),4*ones(size(dmsum_2h_WC22)),5*ones(size(dmsum_in_WC1)),6*ones(size(dmsum_2h_WC1))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
multcompare(STATS)

All_dmsum=[dmsum_in_C,dmsum_in_WC22,dmsum_in_WC1];
All_dmsum_groups=[ones(size(dmsum_in_C)),2*ones(size(dmsum_in_WC22)),3*ones(size(dmsum_in_WC1))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
multcompare(STATS)