%This is to plot habituation rate for different conditions
clearvars
close all
path=uigetdir;
cd(path)
filenames_Pre_C120=dir('*C120_Pre_analyzed.mat');
filenames_in_C120=dir('*C120_120in_analyzed.mat');
filenames_2h_C120=dir('*C120_2h_Post_analyzed.mat');
%filenames_3h_C120=dir('*C_3h_Post_analyzed.mat');

filenames_Pre_C20=dir('*C20_Pre_analyzed.mat');
filenames_in_C20=dir('*C20_20in_analyzed.mat');
filenames_2h_C20=dir('*C20_2h_Post_analyzed.mat');
%filenames_3h_C20=dir('*C_3h_Post_analyzed.mat');

filenames_Pre_KB_R10uM=dir('*KB-R10uM_Pre_analyzed.mat');
filenames_in_KB_R10uM=dir('*KB-R10uM_120in_analyzed.mat');
filenames_2h_KB_R10uM=dir('*KB-R10uM_2h_Post_analyzed.mat');
% filenames_3h_KB_R10uM=dir('*KB-R10uM_3h_Post_analyzed.mat');

filenames_Pre_A=dir('*A_Pre_analyzed.mat');
filenames_in_A=dir('*A_20in_analyzed.mat');
filenames_2h_A=dir('*A_2h_Post_analyzed.mat');
% filenames_3h_A=dir('*A_3h_Post_analyzed.mat');

filenames_Pre_KB_R5uM=dir('*KB-R5uM_Pre_analyzed.mat');
filenames_in_KB_R5uM=dir('*KB-R5uM_120in_analyzed.mat');
filenames_2h_KB_R5uM=dir('*KB-R5uM_2h_Post_analyzed.mat');
% filenames_3h_KB_R5uM=dir('*KB-R5uM_Post_analyzed.mat');

fn_baseline_in_C120=dir('*C120_120in_baseline_analyzed.mat');
fn_baseline_2h_C120=dir('*C120_2h_Post_baseline_analyzed.mat');

fn_baseline_in_C20=dir('*C20_20in_baseline_analyzed.mat');
fn_baseline_2h_C20=dir('*C20_2h_Post_baseline_analyzed.mat');

fn_baseline_in_KB_R10uM=dir('*KB-R10uM_120in_baseline_analyzed.mat');
fn_baseline_2h_KB_R10uM=dir('*KB-R10uM_2h_Post_baseline_analyzed.mat');

fn_baseline_in_KB_R5uM=dir('*KB-R5uM_120in_baseline_analyzed.mat');
fn_baseline_2h_KB_R5uM=dir('*KB-R5uM_2h_Post_baseline_analyzed.mat');

fn_baseline_in_A=dir('*A_20in_baseline_analyzed.mat');
fn_baseline_2h_A=dir('*A_2h_Post_baseline_analyzed.mat');
%% analyze control 1
Resp_Pre_C120=[];
for i=1:length(filenames_Pre_C120)
    d=load(filenames_Pre_C120(i).name);
    Resp_Pre_C120=[Resp_Pre_C120;d.Resp(:,1:20)];
end
Resp_in_C120=[];
for i=1:length(filenames_in_C120)
    d=load(filenames_in_C120(i).name);
    Resp_in_C120=[Resp_in_C120;d.Resp(:,1:20)];
end
Resp_2h_C120=[];
for i=1:length(filenames_2h_C120)
    d=load(filenames_2h_C120(i).name);
    Resp_2h_C120=[Resp_2h_C120;d.Resp(:,1:20)];
end
% Resp_3h_C120=[];
% for i=1:length(filenames_3h_C120)
%     d=load(filenames_3h_C120(i).name);
%     Resp_3h_C120=[Resp_3h_C120;d.Resp(:,1:20)];
% end


resp_prob_Pre_C120=nanmean(Resp_Pre_C120,1);
figure;title('Control'); plot(resp_prob_Pre_C120,'*-');hold on
f=fit((1:1:20)',(resp_prob_Pre_C120)','exp1');plot(f,(1:1:20)',(resp_prob_Pre_C120)')

resp_prob_in_C120=nanmean(Resp_in_C120,1);

plot((21:1:40)',resp_prob_in_C120,'*-');hold on
f=fit((21:1:40)',(resp_prob_in_C120)','exp1');plot(f,(21:1:40)',(resp_prob_in_C120)')

resp_prob_2h_C120=nanmean(Resp_2h_C120,1);
plot((41:1:60)',resp_prob_2h_C120,'*-');hold on
f=fit((41:1:60)',(resp_prob_2h_C120)','exp1');plot(f,(41:1:60)',(resp_prob_2h_C120)')

% resp_prob_3h_C120=nanmean(Resp_3h_C120,1);
% plot((61:1:80)',resp_prob_3h_C120,'*-');hold on
% f=fit((61:1:80)',(resp_prob_3h_C120)','exp1');plot(f,(61:1:80)',(resp_prob_3h_C120)')
title('2 hour control')
legend 'off'
ylim([0,1]);
%% analyze control 2

Resp_Pre_C20=[];
for i=1:length(filenames_Pre_C20)
    d=load(filenames_Pre_C20(i).name);
    Resp_Pre_C20=[Resp_Pre_C20;d.Resp(:,1:20)];
end
Resp_in_C20=[];
for i=1:length(filenames_in_C20)
    d=load(filenames_in_C20(i).name);
    Resp_in_C20=[Resp_in_C20;d.Resp(:,1:20)];
end
Resp_2h_C20=[];
for i=1:length(filenames_2h_C20)
    d=load(filenames_2h_C20(i).name);
    Resp_2h_C20=[Resp_2h_C20;d.Resp(:,1:20)];
end
% Resp_3h_C20=[];
% for i=1:length(filenames_3h_C20)
%     d=load(filenames_3h_C20(i).name);
%     Resp_3h_C20=[Resp_3h_C20;d.Resp(:,1:20)];
% end


resp_prob_Pre_C20=nanmean(Resp_Pre_C20,1);
figure;title('Control'); plot(resp_prob_Pre_C20,'*-');hold on
f=fit((1:1:20)',(resp_prob_Pre_C20)','exp1');plot(f,(1:1:20)',(resp_prob_Pre_C20)')

resp_prob_in_C20=nanmean(Resp_in_C20,1);

plot((21:1:40)',resp_prob_in_C20,'*-');hold on
f=fit((21:1:40)',(resp_prob_in_C20)','exp1');plot(f,(21:1:40)',(resp_prob_in_C20)')

resp_prob_2h_C20=nanmean(Resp_2h_C20,1);
plot((41:1:60)',resp_prob_2h_C20,'*-');hold on
f=fit((41:1:60)',(resp_prob_2h_C20)','exp1');plot(f,(41:1:60)',(resp_prob_2h_C20)')

% resp_prob_3h_C20=nanmean(Resp_3h_C20,1);
% plot((61:1:80)',resp_prob_3h_C20,'*-');hold on
% f=fit((61:1:80)',(resp_prob_3h_C20)','exp1');plot(f,(61:1:80)',(resp_prob_3h_C20)')
title('20 min  control')
legend 'off'
ylim([0,1]);
%% do the same for KB_R10uM


Resp_Pre_KB_R10uM=[];
for i=1:length(filenames_Pre_KB_R10uM)
    d=load(filenames_Pre_KB_R10uM(i).name);
    Resp_Pre_KB_R10uM=[Resp_Pre_KB_R10uM;d.Resp(:,1:20)];
end
Resp_in_KB_R10uM=[];
for i=1:length(filenames_in_KB_R10uM)
    d=load(filenames_in_KB_R10uM(i).name);
    Resp_in_KB_R10uM=[Resp_in_KB_R10uM;d.Resp(:,1:20)];
end
Resp_2h_KB_R10uM=[];
for i=1:length(filenames_2h_KB_R10uM)
    d=load(filenames_2h_KB_R10uM(i).name);
    Resp_2h_KB_R10uM=[Resp_2h_KB_R10uM;d.Resp(:,1:20)];
end
% Resp_3h_KB_R10uM=[];
% for i=1:length(filenames_3h_KB_R10uM)
%     d=load(filenames_3h_KB_R10uM(i).name);
%     Resp_3h_KB_R10uM=[Resp_3h_KB_R10uM;d.Resp(:,1:20)];
% end

resp_prob_Pre_KB_R10uM=nanmean(Resp_Pre_KB_R10uM,1);
figure;title('Control'); plot(resp_prob_Pre_KB_R10uM,'*-');hold on
f=fit((1:1:20)',(resp_prob_Pre_KB_R10uM)','exp1');plot(f,(1:1:20)',(resp_prob_Pre_KB_R10uM)')

resp_prob_in_KB_R10uM=nanmean(Resp_in_KB_R10uM,1);

plot((21:1:40)',resp_prob_in_KB_R10uM,'*-');hold on
f=fit((21:1:40)',(resp_prob_in_KB_R10uM)','exp1');plot(f,(21:1:40)',(resp_prob_in_KB_R10uM)')

resp_prob_2h_KB_R10uM=nanmean(Resp_2h_KB_R10uM,1);
plot((41:1:60)',resp_prob_2h_KB_R10uM,'*-');hold on
f=fit((41:1:60)',(resp_prob_2h_KB_R10uM)','exp1');plot(f,(41:1:60)',(resp_prob_2h_KB_R10uM)')

% resp_prob_3h_KB_R10uM=nanmean(Resp_3h_KB_R10uM,1);
% plot((61:1:80)',resp_prob_3h_KB_R10uM,'*-');hold on
% f=fit((61:1:80)',(resp_prob_3h_KB_R10uM)','exp1');plot(f,(61:1:80)',(resp_prob_3h_KB_R10uM)')

legend 'off'
ylim([0,1]);
title('KB-R7943- 10 uM')
%% do the same for KB_R5uM


Resp_Pre_KB_R5uM=[];
for i=1:length(filenames_Pre_KB_R5uM)
    d=load(filenames_Pre_KB_R5uM(i).name);
    Resp_Pre_KB_R5uM=[Resp_Pre_KB_R5uM;d.Resp(:,1:20)];
end
Resp_in_KB_R5uM=[];
for i=1:length(filenames_in_KB_R5uM)
    d=load(filenames_in_KB_R5uM(i).name);
    Resp_in_KB_R5uM=[Resp_in_KB_R5uM;d.Resp(:,1:20)];
end
Resp_2h_KB_R5uM=[];
for i=1:length(filenames_2h_KB_R5uM)
    d=load(filenames_2h_KB_R5uM(i).name);
    Resp_2h_KB_R5uM=[Resp_2h_KB_R5uM;d.Resp(:,1:20)];
end
% Resp_3h_KB_R5uM=[];
% for i=1:length(filenames_3h_KB_R5uM)
%     d=load(filenames_3h_KB_R5uM(i).name);
%     Resp_3h_KB_R5uM=[Resp_3h_KB_R5uM;d.Resp(:,1:20)];
% end

resp_prob_Pre_KB_R5uM=nanmean(Resp_Pre_KB_R5uM,1);
figure;title('Control'); plot(resp_prob_Pre_KB_R5uM,'*-');hold on
f=fit((1:1:20)',(resp_prob_Pre_KB_R5uM)','exp1');plot(f,(1:1:20)',(resp_prob_Pre_KB_R5uM)')

resp_prob_in_KB_R5uM=nanmean(Resp_in_KB_R5uM,1);

plot((21:1:40)',resp_prob_in_KB_R5uM,'*-');hold on
f=fit((21:1:40)',(resp_prob_in_KB_R5uM)','exp1');plot(f,(21:1:40)',(resp_prob_in_KB_R5uM)')

resp_prob_2h_KB_R5uM=nanmean(Resp_2h_KB_R5uM,1);
plot((41:1:60)',resp_prob_2h_KB_R5uM,'*-');hold on
f=fit((41:1:60)',(resp_prob_2h_KB_R5uM)','exp1');plot(f,(41:1:60)',(resp_prob_2h_KB_R5uM)')

% resp_prob_3h_KB_R5uM=nanmean(Resp_3h_KB_R5uM,1);
% plot((61:1:80)',resp_prob_3h_KB_R5uM,'*-');hold on
% f=fit((61:1:80)',(resp_prob_3h_KB_R5uM)','exp1');plot(f,(61:1:80)',(resp_prob_3h_KB_R10uM)')

legend 'off'
ylim([0,1]);
title('KB-R7943- 5uM')
%% do the same for A


Resp_Pre_A=[];
for i=1:length(filenames_Pre_A)
    d=load(filenames_Pre_A(i).name);
    Resp_Pre_A=[Resp_Pre_A;d.Resp(:,1:20)];
end
Resp_in_A=[];
for i=1:length(filenames_in_A)
    d=load(filenames_in_A(i).name);
    Resp_in_A=[Resp_in_A;d.Resp(:,1:20)];
end
Resp_2h_A=[];
for i=1:length(filenames_2h_A)
    d=load(filenames_2h_A(i).name);
    Resp_2h_A=[Resp_2h_A;d.Resp(:,1:20)];
end
% Resp_3h_A=[];
% for i=1:length(filenames_3h_A)
%     d=load(filenames_3h_A(i).name);
%     Resp_3h_A=[Resp_3h_A;d.Resp(:,1:20)];
% end

resp_prob_Pre_A=nanmean(Resp_Pre_A,1);
figure;title('Control'); plot(resp_prob_Pre_A,'*-');hold on
f=fit((1:1:20)',(resp_prob_Pre_A)','exp1');plot(f,(1:1:20)',(resp_prob_Pre_A)')

resp_prob_in_A=nanmean(Resp_in_A,1);

plot((21:1:40)',resp_prob_in_A,'*-');hold on
f=fit((21:1:40)',(resp_prob_in_A)','exp1');plot(f,(21:1:40)',(resp_prob_in_A)')

resp_prob_2h_A=nanmean(Resp_2h_A,1);
plot((41:1:60)',resp_prob_2h_A,'*-');hold on
f=fit((41:1:60)',(resp_prob_2h_A)','exp1');plot(f,(41:1:60)',(resp_prob_2h_A)')

% resp_prob_3h_A=nanmean(Resp_3h_A,1);
% plot((61:1:80)',resp_prob_3h_A,'*-');hold on
% f=fit((61:1:80)',(resp_prob_3h_A)','exp1');plot(f,(61:1:80)',(resp_prob_3h_A)')

legend 'off'
ylim([0,1]);
title('Aprindine')
%% compare baseline activities
%control 1
thresh=0.5
nframes=38*60*5;

dm_in_C120=[];
for i=1:length(fn_baseline_in_C120)
    d=load(fn_baseline_in_C120(i).name);
    dm_in_C120=[dm_in_C120;d.dm(:,1:nframes)];
end
%Median_dm_in_C120=nanmedian(reshape(dm_in_C120,[1,numel(dm_in_C120)]));
for i=1:size(dm_in_C120,1)
    index=find(dm_in_C120(i,:)<thresh);
    dm_in_C120(i,index)=0;
    dmsum_in_C120(i)=nansum(dm_in_C120(i,:));
end

dm_2h_C120=[];
for i=1:length(fn_baseline_2h_C120)
    d=load(fn_baseline_2h_C120(i).name);
    dm_2h_C120=[dm_2h_C120;d.dm(:,1:nframes)];
end
%Median_dm_2h_C120=nanmedian(reshape(dm_2h_C120,[1,numel(dm_2h_C120)]));
for i=1:size(dm_2h_C120,1)
    index=find(dm_2h_C120(i,:)<thresh);
    dm_2h_C120(i,index)=0;
    dmsum_2h_C120(i)=nansum(dm_2h_C120(i,:));
end
%control 2
thresh=0.5;
nframes=38*60*5;

dm_in_C20=[];
for i=1:length(fn_baseline_in_C20)
    d=load(fn_baseline_in_C20(i).name);
    dm_in_C20=[dm_in_C20;d.dm(:,1:nframes)];
end
%Median_dm_in_C20=nanmedian(reshape(dm_in_C20,[1,numel(dm_in_C20)]));
for i=1:size(dm_in_C20,1)
    index=find(dm_in_C20(i,:)<thresh);
    dm_in_C20(i,index)=0;
    dmsum_in_C20(i)=nansum(dm_in_C20(i,:));
end

dm_2h_C20=[];
for i=1:length(fn_baseline_2h_C20)
    d=load(fn_baseline_2h_C20(i).name);
    dm_2h_C20=[dm_2h_C20;d.dm(:,1:nframes)];
end
%Median_dm_2h_C20=nanmedian(reshape(dm_2h_C20,[1,numel(dm_2h_C20)]));
for i=1:size(dm_2h_C20,1)
    index=find(dm_2h_C20(i,:)<thresh);
    dm_2h_C20(i,index)=0;
    dmsum_2h_C20(i)=nansum(dm_2h_C20(i,:));
end
%% do the same for KB_R10uM
dm_in_KB_R10uM=[];
for i=1:length(fn_baseline_in_KB_R10uM)
    d=load(fn_baseline_in_KB_R10uM(i).name);
    dm_in_KB_R10uM=[dm_in_KB_R10uM;d.dm(:,1:nframes)];
end
%Median_dm_in_KB_R10uM=nanmedian(reshape(dm_in_KB_R10uM,[1,numel(dm_in_KB_R10uM)]));
for i=1:size(dm_in_KB_R10uM,1)
    index=find(dm_in_KB_R10uM(i,:)<thresh);
    dm_in_KB_R10uM(i,index)=0;
    dmsum_in_KB_R10uM(i)=nansum(dm_in_KB_R10uM(i,:));
end

dm_2h_KB_R10uM=[];
for i=1:length(fn_baseline_2h_KB_R10uM)
    d=load(fn_baseline_2h_KB_R10uM(i).name);
    dm_2h_KB_R10uM=[dm_2h_KB_R10uM;d.dm(:,1:nframes)];
end
%Median_dm_2h_KB_R10uM=nanmedian(reshape(dm_2h_KB_R10uM,[1,numel(dm_2h_KB_R10uM)]));
for i=1:size(dm_2h_KB_R10uM,1)
    index=find(dm_2h_KB_R10uM(i,:)<thresh);
    dm_2h_KB_R10uM(i,index)=0;
    dmsum_2h_KB_R10uM(i)=sum(dm_2h_KB_R10uM(i,:));
end
%% do the same for KB_R5uM
dm_in_KB_R5uM=[];
for i=1:length(fn_baseline_in_KB_R5uM)
    d=load(fn_baseline_in_KB_R5uM(i).name);
    dm_in_KB_R5uM=[dm_in_KB_R5uM;d.dm(:,1:nframes)];
end
%Median_dm_in_KB_R5uM=nanmedian(reshape(dm_in_KB_R5uM,[1,numel(dm_in_KB_R5uM)]));
for i=1:size(dm_in_KB_R5uM,1)
    index=find(dm_in_KB_R5uM(i,:)<thresh);
    dm_in_KB_R5uM(i,index)=0;
    dmsum_in_KB_R5uM(i)=nansum(dm_in_KB_R5uM(i,:));
end

dm_2h_KB_R5uM=[];
for i=1:length(fn_baseline_2h_KB_R5uM)
    d=load(fn_baseline_2h_KB_R5uM(i).name);
    dm_2h_KB_R5uM=[dm_2h_KB_R5uM;d.dm(:,1:nframes)];
end
%Median_dm_2h_KB_R5uM=nanmedian(reshape(dm_2h_KB_R5uM,[1,numel(dm_2h_KB_R5uM)]));
for i=1:size(dm_2h_KB_R5uM,1)
    index=find(dm_2h_KB_R5uM(i,:)<thresh);
    dm_2h_KB_R5uM(i,index)=0;
    dmsum_2h_KB_R5uM(i)=sum(dm_2h_KB_R5uM(i,:));
end
%% do the same for A

dm_in_A=[];
for i=1:length(fn_baseline_in_A)
    d=load(fn_baseline_in_A(i).name);
    dm_in_A=[dm_in_A;d.dm(:,1:nframes)];
end
%Median_dm_in_A=nanmedian(reshape(dm_in_A,[1,numel(dm_in_A)]));
for i=1:size(dm_in_A,1)
    index=find(dm_in_A(i,:)<thresh);
    dm_in_A(i,index)=0;
    dmsum_in_A(i)=nansum(dm_in_A(i,:));
end

dm_2h_A=[];
for i=1:length(fn_baseline_2h_A)
    d=load(fn_baseline_2h_A(i).name);
    dm_2h_A=[dm_2h_A;d.dm(:,1:nframes)];
end
%Median_dm_2h_A=nanmedian(reshape(dm_2h_A,[1,numel(dm_2h_A)]));
for i=1:size(dm_2h_A,1)
    index=find(dm_2h_A(i,:)<thresh);
    dm_2h_A(i,index)=0;
    dmsum_2h_A(i)=nansum(dm_2h_A(i,:));
end
%%

All_dmsum=[dmsum_2h_C20,dmsum_2h_C120,dmsum_2h_KB_R5uM,dmsum_2h_KB_R10uM,dmsum_2h_A];
All_dmsum_groups=[ones(size(dmsum_2h_C20)),2*ones(size(dmsum_2h_C120)),3*ones(size(dmsum_2h_KB_R5uM)),4*ones(size(dmsum_2h_KB_R10uM)),5*ones(size(dmsum_2h_A))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
multcompare(STATS)

All_dmsum=[dmsum_in_C20,dmsum_in_C120,dmsum_in_KB_R5uM, dmsum_in_KB_R10uM,dmsum_in_A];
All_dmsum_groups=[ones(size(dmsum_in_C20)),2*ones(size(dmsum_in_C120)),3*ones(size(dmsum_in_KB_R5uM)),4*ones(size(dmsum_in_KB_R10uM)),5*ones(size(dmsum_in_A))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
figure
multcompare(STATS)