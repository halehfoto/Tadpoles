%This is to plot habituation rate for different conditions, this code works
%for only the case where there is a common treatment time for all drugs.

clearvars
close all
path=uigetdir;
cd(path)
Drugs=input('please enter drug names as as entered in the file name as a comma separated string list inside curley brackets, in the same order as D1, D2 ... include concentration in the name multiple needed');
Stim_In=input('Was there stimulation during stasis 1 for yes and 0 for no:');
if Stim_In
    stimstr='_SG';
else
    stimstr=[];
end
filenames_Pre_C=dir(strcat('*_C*_Pre',stimstr,'_analyzed.mat'));
filenames_in_C=dir('*_C*_In_SG_analyzed.mat');
filenames_2h_C=dir('*_C*_2h_Post_SG_analyzed.mat');
filenames_3h_C=dir('*_C*_3h_Post_SG_analyzed.mat');

fn_baseline_C=dir('*_C*_Pre_baseline_SG_analyzed.mat');
fn_baseline_in_C=dir('*_C*_In*_baseline_SG_analyzed.mat');
fn_baseline_2h_C=dir('*_C*_Post_baseline_analyzed.mat');

for i=1:length(Drugs)
    filenames_Pre{i}=dir(strcat('*D',num2str(i),'*_Pre_analyzed.mat'));
    filenames_in{i}=dir(strcat('*D',num2str(i),'*_In_analyzed.mat'));
    filenames_2h{i}=dir(strcat('*D',num2str(i),'*_2h_Post_analyzed.mat'));
    filenames_3h{i}=dir(strcat('*D',num2str(i),'*_3h_Post_analyzed.mat'));
    
    filenames_Pre_baseline{i}=dir(strcat('*D',num2str(i),'*_Pre_baseline_analyzed.mat'));
    filenames_in_baseline{i}=dir(strcat('*D',num2str(i),'*_In_baseline_analyzed.mat'));
    filenames_2h_baseline{i}=dir(strcat('*D',num2str(i),'*_2h_Post_baseline_analyzed.mat'));
    filenames_3h_baseline{i}=dir(strcat('*D',num2str(i),'*_3h_Post_baseline_analyzed.mat'));

end


%% analyze control 1
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
    temp=NaN(size(d.Resp,1),20);
    if size(d.Resp,2)<20
        for j=1:20
            temp(j,1:size(d.Resp,2))=d.Resp(j,:);
        end
    else
        temp=d.Resp(:,1:20);
    end
     Resp_2h_C=[Resp_2h_C;temp];

end
Resp_3h_C=[];
for i=1:length(filenames_3h_C)
    d=load(filenames_3h_C(i).name);
    temp=NaN(size(d.Resp,1),20);
    if size(d.Resp,2)<20
        for j=1:20
            temp(j,1:size(d.Resp,2))=d.Resp(j,:);
        end
    else
        temp=d.Resp(:,1:20);
    end
     Resp_3h_C=[Resp_3h_C;temp];

end


resp_prob_Pre_C=nanmean(Resp_Pre_C,1);
figure;title('Control'); plot(resp_prob_Pre_C,'*-');hold on
f=fit((1:1:20)',(resp_prob_Pre_C)','exp1');plot(f,(1:1:20)',(resp_prob_Pre_C)')

if Stim_In
    resp_prob_in_C=nanmean(Resp_in_C,1);
    plot((21:1:40)',resp_prob_in_C,'*-');hold on
    f=fit((21:1:40)',(resp_prob_in_C)','exp1');plot(f,(21:1:40)',(resp_prob_in_C)')
end
resp_prob_2h_C=nanmean(Resp_2h_C,1);
plot((41:1:sum(~isnan(resp_prob_2h_C))+40)',resp_prob_2h_C(1:sum(~isnan(resp_prob_2h_C))),'*-');hold on
f=fit((41:1:sum(~isnan(resp_prob_2h_C))+40)',(resp_prob_2h_C(1:sum(~isnan(resp_prob_2h_C))))','exp1');plot(f,(41:1:sum(~isnan(resp_prob_2h_C))+40)',(resp_prob_2h_C(1:sum(~isnan(resp_prob_2h_C))))')

resp_prob_3h_C=nanmean(Resp_3h_C,1);
plot((61:1:sum(~isnan(resp_prob_3h_C))+60)',resp_prob_2h_C(1:sum(~isnan(resp_prob_3h_C))),'*-');hold on
f=fit((61:1:sum(~isnan(resp_prob_3h_C))+60)',(resp_prob_2h_C(1:sum(~isnan(resp_prob_3h_C))))','exp1');plot(f,(61:1:sum(~isnan(resp_prob_3h_C))+60)',(resp_prob_2h_C(1:sum(~isnan(resp_prob_3h_C))))')

title('2 hour control')
legend 'off'
ylim([0,1]);

%% do the same for the drugs


Resp_Pre_D1=[];
for i=1:length(filenames_Pre{1})
    d=load(filenames_Pre{1}(i).name);
    Resp_Pre_D1=[Resp_Pre_D1;d.Resp(:,1:20)];
end
Resp_in_D1=[];
for i=1:length(filenames_in{1})
    d=load(filenames_in{1}.name);
    Resp_in_D1=[Resp_in_D1;d.Resp(:,1:20)];
end
Resp_2h_D1=[];
for i=1:length(filenames_2h{1})
    d=load(filenames_2h{1}(i).name);
    Resp_2h_D1=[Resp_2h_D1;d.Resp(:,1:20)];
end

Resp_3h_D1=[];
for i=1:length(filenames_3h{1})
    d=load(filenames_3h{1}(i).name);
    Resp_3h_D1=[Resp_3h_D1;d.Resp(:,1:20)];
end
resp_prob_Pre_D1=nanmean(Resp_Pre_D1,1);
figure;title('Control'); plot(resp_prob_Pre_D1,'*-');hold on
f=fit((1:1:20)',(resp_prob_Pre_D1)','exp1');plot(f,(1:1:20)',(resp_prob_Pre_D1)')

if Stim_In
    resp_prob_in_D1=nanmean(Resp_in_D1,1);
    plot((21:1:40)',resp_prob_in_D1,'*-');hold on
    f=fit((21:1:40)',(resp_prob_in_D1)','exp1');plot(f,(21:1:40)',(resp_prob_in_D1)')
end

resp_prob_2h_D1=nanmean(Resp_2h_D1,1);
plot((41:1:60)',resp_prob_2h_D1,'*-');hold on
f=fit((41:1:60)',(resp_prob_2h_D1)','exp1');plot(f,(41:1:60)',(resp_prob_2h_D1)')

resp_prob_3h_D1=nanmean(Resp_3h_D1,1);
plot((61:1:80)',resp_prob_3h_D1,'*-');hold on
f=fit((61:1:80)',(resp_prob_3h_D1)','exp1');plot(f,(61:1:80)',(resp_prob_3h_D1)')


legend 'off'
ylim([0,1]);
title('D1')
%% do the same for D2


Resp_Pre_D2=[];
for i=1:length(filenames_Pre{2})
    d=load(filenames_Pre{2}(i).name);
    Resp_Pre_D2=[Resp_Pre_D2;d.Resp(:,1:20)];
end

if Stim_In
    Resp_in_D2=[];
    for i=1:length(filenames_in{2})
        d=load(filenames_in{2}.name);
        Resp_in_D2=[Resp_in_D2;d.Resp(:,1:20)];
    end
end

Resp_2h_D2=[];
for i=1:length(filenames_2h{2})
    d=load(filenames_2h{2}(i).name);
    temp=NaN(size(d.Resp,1),20);
    if size(d.Resp,2)<20
        for j=1:20
            temp(j,1:size(d.Resp,2))=d.Resp(j,:);
        end
    else
        temp=d.Resp(:,1:20);
    end

    Resp_2h_D2=[Resp_2h_D2;temp];
        
end

Resp_3h_D2=[];
for i=1:length(filenames_3h{2})
    d=load(filenames_3h{2}(i).name);
    Resp_3h_D2=[Resp_3h_D2;d.Resp(:,1:20)];
end


resp_prob_Pre_D2=nanmean(Resp_Pre_D2,1);
figure;title('Control'); plot(resp_prob_Pre_D2,'*-');hold on
f=fit((1:1:20)',(resp_prob_Pre_D2)','exp1');plot(f,(1:1:20)',(resp_prob_Pre_D2)')

if Stim_In
    resp_prob_in_D2=nanmean(Resp_in_D2,1);

    plot((21:1:40)',resp_prob_in_D2,'*-');hold on
    f=fit((21:1:40)',(resp_prob_in_D2)','exp1');plot(f,(21:1:40)',(resp_prob_in_D2)')
end
resp_prob_2h_D2=nanmean(Resp_2h_D2,1);
plot((41:1:60)',resp_prob_2h_D2,'*-');hold on
f=fit((41:1:60)',(resp_prob_2h_D2)','exp1');plot(f,(41:1:60)',(resp_prob_2h_D2)')

resp_prob_3h_D2=nanmean(Resp_3h_D2,1);
plot((61:1:80)',resp_prob_3h_D2,'*-');hold on
f=fit((61:1:80)',(resp_prob_3h_D2)','exp1');plot(f,(61:1:80)',(resp_prob_3h_D2)')


legend 'off'
ylim([0,1]);
title('D2')


%% compare baseline activities
%control 1
thresh=0.5
nframes=37*60*5;

dm_in_C=[];
for i=1:length(fn_baseline_in_C)
    d=load(fn_baseline_in_C(i).name);
    dm_in_C=[dm_in_C;d.dm(:,1:nframes)];
end
%Median_dm_in_C120=nanmedian(reshape(dm_in_C120,[1,numel(dm_in_C120)]));
for i=1:size(dm_in_C,1)
    index=find(dm_in_C(i,:)<thresh);
    dm_in_C(i,index)=0;
    dmsum_in_C(i)=nansum(dm_in_C(i,:));
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