%This is to plot habituation rate for different conditions, this code works
%for only the case where there is a common treatment time for all drugs.

clearvars
close all
path=uigetdir;
cd(path)
Drugs=input('please enter drug names as as entered in the file name as a comma separated string list inside curley brackets, in the same order as D1, D2 ... include concentration in the name multiple needed');
Stim_In=input('Was there stimulation during stasis 1 for yes and 0 for no:');
fps=input('Please enter the frame rate:')
if Stim_In
    stimstr='_SG';
else
    stimstr=[];
end
filenames_Pre_C=dir(strcat('*_C*_Pre',stimstr,'_analyzed.mat'));
filenames_in_C=dir(strcat('*_C*_In',stimstr,'_analyzed.mat'));
filenames_2h_C=dir(strcat('*_C*_2h_Post',stimstr,'_analyzed.mat'));
filenames_3h_C=dir(strcat('*_C*_3h_Post',stimstr,'_analyzed.mat'));
filenames_5h_C=dir(strcat('*_C*_5h_Post',stimstr,'_analyzed.mat'));
filenames_7h_C=dir(strcat('*_C*_7h_Post',stimstr,'_analyzed.mat'));

fn_baseline_C=dir(strcat('*_C*_Pre_baseline',stimstr,'_analyzed.mat'));
fn_baseline_in_C=dir(strcat('*_C*_In*_baseline',stimstr,'_analyzed.mat'));
fn_baseline_2h_C=dir(strcat('*_C*_2h_Post_baseline',stimstr,'_analyzed.mat'));
fn_baseline_5h_C=dir(strcat('*_C*_5h_Post_baseline',stimstr,'_analyzed.mat'));
fn_baseline_7h_C=dir(strcat('*_C*_5h_Post_baseline',stimstr,'_analyzed.mat'));

for i=1:length(Drugs)
    filenames_Pre{i}=dir(strcat('*D',num2str(i),'*_Pre',stimstr,'_analyzed.mat'));
    filenames_in{i}=dir(strcat('*D',num2str(i),'*_In',stimstr,'_analyzed.mat'));
    filenames_2h{i}=dir(strcat('*D',num2str(i),'*_2h_Post',stimstr,'_analyzed.mat'));
    filenames_3h{i}=dir(strcat('*D',num2str(i),'*_3h_Post',stimstr,'_analyzed.mat'));
    filenames_5h{i}=dir(strcat('*D',num2str(i),'*_5h_Post',stimstr,'_analyzed.mat'));
    filenames_5h{i}=dir(strcat('*D',num2str(i),'*_5h_Post',stimstr,'_analyzed.mat'));

    filenames_Pre_baseline{i}=dir(strcat('*D',num2str(i),'*_Pre_baseline',stimstr,'_analyzed.mat'));
    filenames_in_baseline{i}=dir(strcat('*D',num2str(i),'*_In_baseline',stimstr,'_analyzed.mat'));
    filenames_2h_baseline{i}=dir(strcat('*D',num2str(i),'*_2h_Post_baseline',stimstr,'_analyzed.mat'));
    filenames_3h_baseline{i}=dir(strcat('*D',num2str(i),'*_3h_Post_baseline',stimstr,'_analyzed.mat'));
    filenames_5h_baseline{i}=dir(strcat('*D',num2str(i),'*_5h_Post_baseline',stimstr,'_analyzed.mat'));
    filenames_7h{i}=dir(strcat('*D',num2str(i),'*_5h_Post',stimstr,'_analyzed.mat'));

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
Resp_5h_C=[];
for i=1:length(filenames_5h_C)
    d=load(filenames_5h_C(i).name);
    temp=NaN(size(d.Resp,1),20);
    if size(d.Resp,2)<20
        for j=1:20
            temp(j,1:size(d.Resp,2))=d.Resp(j,:);
        end
    else
        temp=d.Resp(:,1:20);
    end
     Resp_5h_C=[Resp_5h_C;temp];

end

resp_prob_Pre_C=nanmean(Resp_Pre_C,1);
figure;title('Control'); plot(resp_prob_Pre_C,'*');hold on
f=fit((1:1:20)',(resp_prob_Pre_C)','exp1');plot(f,(1:1:20)',(resp_prob_Pre_C)')

if Stim_In
    resp_prob_in_C=nanmean(Resp_in_C,1);
    plot((21:1:40)',resp_prob_in_C,'*');hold on
    f=fit((21:1:40)',(resp_prob_in_C)','exp1');plot(f,(21:1:40)',(resp_prob_in_C)')
end
if ~isempty(Resp_2h_C)

    resp_prob_2h_C=nanmean(Resp_2h_C,1);
    plot((41:1:sum(~isnan(resp_prob_2h_C))+40)',resp_prob_2h_C(1:sum(~isnan(resp_prob_2h_C))),'*');hold on
    f=fit((41:1:sum(~isnan(resp_prob_2h_C))+40)',(resp_prob_2h_C(1:sum(~isnan(resp_prob_2h_C))))','exp1');plot(f,(41:1:sum(~isnan(resp_prob_2h_C))+40)',(resp_prob_2h_C(1:sum(~isnan(resp_prob_2h_C))))')
end

if ~isempty(Resp_3h_C)
    resp_prob_3h_C=nanmean(Resp_3h_C,1);
    plot((61:1:sum(~isnan(resp_prob_3h_C))+60)',resp_prob_3h_C(1:sum(~isnan(resp_prob_3h_C))),'*');hold on
    f=fit((61:1:sum(~isnan(resp_prob_3h_C))+60)',(resp_prob_3h_C(1:sum(~isnan(resp_prob_3h_C))))','exp1');plot(f,(61:1:sum(~isnan(resp_prob_3h_C))+60)',(resp_prob_3h_C(1:sum(~isnan(resp_prob_3h_C))))')
end
if ~isempty(Resp_5h_C)
    resp_prob_5h_C=nanmean(Resp_5h_C,1);
    plot((81:1:sum(~isnan(resp_prob_5h_C))+80)',resp_prob_5h_C(1:sum(~isnan(resp_prob_5h_C))),'*');hold on
    f=fit((81:1:sum(~isnan(resp_prob_5h_C))+80)',(resp_prob_5h_C(1:sum(~isnan(resp_prob_5h_C))))','exp1');plot(f,(81:1:sum(~isnan(resp_prob_5h_C))+80)',(resp_prob_5h_C(1:sum(~isnan(resp_prob_5h_C))))')
end

title('control')
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
    d=load(filenames_in{1}(i).name);
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
Resp_5h_D1=[];
for i=1:length(filenames_5h{1})
    d=load(filenames_5h{1}(i).name);
    Resp_5h_D1=[Resp_5h_D1;d.Resp(:,1:20)];
end

resp_prob_Pre_D1=nanmean(Resp_Pre_D1,1);
figure;title('Control'); plot(resp_prob_Pre_D1,'*');hold on
f=fit((1:1:20)',(resp_prob_Pre_D1)','exp1');plot(f,(1:1:20)',(resp_prob_Pre_D1)')

if Stim_In
    resp_prob_in_D1=nanmean(Resp_in_D1,1);
    plot((21:1:40)',resp_prob_in_D1,'*');hold on
    f=fit((21:1:40)',(resp_prob_in_D1)','exp1');plot(f,(21:1:40)',(resp_prob_in_D1)')
end
if ~isempty(Resp_2h_D1)
    resp_prob_2h_D1=nanmean(Resp_2h_D1,1);
    plot((41:1:60)',resp_prob_2h_D1,'*');hold on
    f=fit((41:1:60)',(resp_prob_2h_D1)','exp1');plot(f,(41:1:60)',(resp_prob_2h_D1)')
end
if ~isempty(Resp_3h_D1)
    resp_prob_3h_D1=nanmean(Resp_3h_D1,1);
    plot((61:1:80)',resp_prob_3h_D1,'*');hold on
    f=fit((61:1:80)',(resp_prob_3h_D1)','exp1');plot(f,(61:1:80)',(resp_prob_3h_D1)')
end
if ~isempty(Resp_5h_D1)
    resp_prob_5h_D1=nanmean(Resp_5h_D1,1);
    plot((81:1:100)',resp_prob_5h_D1,'*');hold on
    f=fit((81:1:100)',(resp_prob_5h_D1)','exp1');plot(f,(81:1:100)',(resp_prob_5h_D1)')
end

legend 'off'
ylim([0,1]);
title(Drugs{1})
%% do the same for D2

if length(Drugs)>1
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
Resp_5h_D2=[];
for i=1:length(filenames_5h{2})
    d=load(filenames_5h{2}(i).name);
    Resp_5h_D2=[Resp_5h_D2;d.Resp(:,1:20)];
end


resp_prob_Pre_D2=nanmean(Resp_Pre_D2,1);
figure;title('Control'); plot(resp_prob_Pre_D2,'*');hold on
f=fit((1:1:20)',(resp_prob_Pre_D2)','exp1');plot(f,(1:1:20)',(resp_prob_Pre_D2)')

if Stim_In
    resp_prob_in_D2=nanmean(Resp_in_D2,1);

    plot((21:1:40)',resp_prob_in_D2,'*');hold on
    f=fit((21:1:40)',(resp_prob_in_D2)','exp1');plot(f,(21:1:40)',(resp_prob_in_D2)')
end
if ~isempty(Resp_2h_D2)
    resp_prob_2h_D2=nanmean(Resp_2h_D2,1);
    plot((41:1:60)',resp_prob_2h_D2,'*');hold on
    f=fit((41:1:60)',(resp_prob_2h_D2)','exp1');plot(f,(41:1:60)',(resp_prob_2h_D2)')
end
if ~isempty(Resp_3h_D2)
    resp_prob_3h_D2=nanmean(Resp_3h_D2,1);
    plot((61:1:80)',resp_prob_3h_D2,'*');hold on
    f=fit((61:1:80)',(resp_prob_3h_D2)','exp1');plot(f,(61:1:80)',(resp_prob_3h_D2)')
end

if ~isempty(Resp_5h_D2)
    resp_prob_5h_D2=nanmean(Resp_5h_D2,1);
    plot((81:1:100)',resp_prob_5h_D2,'*');hold on
    f=fit((81:1:100)',(resp_prob_5h_D2)','exp1');plot(f,(81:1:100)',(resp_prob_5h_D2)')
end

legend 'off'
ylim([0,1]);
title(Drugs{2})

end

%% compare baseline activities
%control 1
thresh=0.5
nframes=fps*60*5;
cmpp=0.03/5;%scaling factor to get movement in cm per minute
dm_Pre_C=[];
for i=1:length(fn_baseline_C)
    d=load(fn_baseline_C(i).name);
    dm_Pre_C=[dm_Pre_C;d.dm(:,1:nframes)];
end
for i=1:size(dm_Pre_C,1)
    index=find(dm_Pre_C(i,:)<thresh);
    dm_Pre_C(i,index)=0;
    dmsum_Pre_C(i)=cmpp*nansum(dm_Pre_C(i,:));
end

dm_in_C=[];
for i=1:length(fn_baseline_in_C)
    d=load(fn_baseline_in_C(i).name);
    dm_in_C=[dm_in_C;d.dm(:,1:nframes)];
end
%Median_dm_in_C120=nanmedian(reshape(dm_in_C120,[1,numel(dm_in_C120)]));
for i=1:size(dm_in_C,1)
    index=find(dm_in_C(i,:)<thresh);
    dm_in_C(i,index)=0;
    dmsum_in_C(i)=cmpp*nansum(dm_in_C(i,:));
end

dm_2h_C=[];
for i=1:length(fn_baseline_2h_C)
    d=load(fn_baseline_2h_C(i).name);
    dm_2h_C=[dm_2h_C;d.dm(:,1:nframes)];
end
%Median_dm_in_C120=nanmedian(reshape(dm_in_C120,[1,numel(dm_in_C120)]));
for i=1:size(dm_2h_C,1)
    index=find(dm_2h_C(i,:)<thresh);
    dm_2h_C(i,index)=0;
    dmsum_2h_C(i)=cmpp*nansum(dm_2h_C(i,:));
end

dm_5h_C=[];
for i=1:length(fn_baseline_5h_C)
    d=load(fn_baseline_5h_C(i).name);
    dm_5h_C=[dm_5h_C;d.dm(:,1:nframes)];
end
%Median_dm_in_C120=nanmedian(reshape(dm_in_C120,[1,numel(dm_in_C120)]));
for i=1:size(dm_5h_C,1)
    index=find(dm_5h_C(i,:)<thresh);
    dm_5h_C(i,index)=0;
    dmsum_5h_C(i)=cmpp*nansum(dm_5h_C(i,:));
end

%% do the same for Drug 1

dm_Pre_D1=[];
for i=1:1%length(filenames_in_baseline{1})
    d=load(filenames_Pre_baseline{1}(i).name);
    dm_Pre_D1=[dm_Pre_D1;d.dm(:,1:nframes)];
end
%Median_dm_in_KB_R10uM=nanmedian(reshape(dm_in_KB_R10uM,[1,numel(dm_in_KB_R10uM)]));
for i=1:size(dm_Pre_D1,1)
    index=find(dm_Pre_D1(i,:)<thresh);
    dm_Pre_D1(i,index)=0;
    dmsum_Pre_D1(i)=cmpp*nansum(dm_Pre_D1(i,:));
end

dm_in_D1=[];
for i=1:length(filenames_in_baseline{1})
    d=load(filenames_in_baseline{1}(i).name);
    dm_in_D1=[dm_in_D1;d.dm(:,1:nframes)];
end
%Median_dm_in_KB_R10uM=nanmedian(reshape(dm_in_KB_R10uM,[1,numel(dm_in_KB_R10uM)]));
for i=1:size(dm_in_D1,1)
    index=find(dm_in_D1(i,:)<thresh);
    dm_in_D1(i,index)=0;
    dmsum_in_D1(i)=cmpp*nansum(dm_in_D1(i,:));
end
if ~isempty(filenames_2h_baseline{1})
    dm_2h_D1=[];
    for i=1:length(filenames_2h_baseline{1}(i).name)
        d=load(filenames_2h_baseline{1}(i).name);
        dm_2h_D1=[dm_2h_D1;d.dm(:,1:nframes)];
    end
    %Median_dm_2h_KB_R10uM=nanmedian(reshape(dm_2h_KB_R10uM,[1,numel(dm_2h_KB_R10uM)]));
    for i=1:size(dm_2h_D1,1)
        index=find(dm_2h_D1(i,:)<thresh);
        dm_2h_D1(i,index)=0;
        dmsum_2h_D1(i)=cmpp*nansum(dm_2h_D1(i,:));
    end
end

if ~isempty(filenames_5h_baseline{1})
    dm_5h_D1=[];
    for i=1:length(filenames_5h_baseline{1})
        d=load(filenames_5h_baseline{1}(i).name);
        dm_5h_D1=[dm_5h_D1;d.dm(:,1:nframes)];
    end
    for i=1:size(dm_5h_D1,1)
        index=find(dm_5h_D1(i,:)<thresh);
        dm_5h_D1(i,index)=0;
        dmsum_5h_D1(i)=cmpp*nansum(dm_5h_D1(i,:));
    end
end

%%

All_dmsum=[dmsum_Pre_D1,dmsum_5h_D1];
All_dmsum_groups=[ones(size(dmsum_Pre_D1)),2*ones(size(dmsum_5h_D1))]
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(strcat(Drugs{1},'-5h Recover'))

multcompare(STATS)

All_dmsum=[dmsum_Pre_D1,dmsum_in_D1];
All_dmsum_groups=[ones(size(dmsum_Pre_D1)),2*ones(size(dmsum_in_D1))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(strcat(Drugs{1},'-90minTreatment'))

figure
multcompare(STATS)

All_dmsum=[dmsum_Pre_D1,dmsum_in_D1,dmsum_5h_D1];
All_dmsum_groups=[ones(size(dmsum_Pre_D1)),2*ones(size(dmsum_in_D1)),3*ones(size(dmsum_5h_D1))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(Drugs{1})

%% do the same for drug 2

dm_Pre_D2=[];
for i=1:1%length(filenames_in_baseline{1})
    d=load(filenames_Pre_baseline{2}(i).name);
    dm_Pre_D2=[dm_Pre_D2;d.dm(:,1:nframes)];
end
%Median_dm_in_KB_R10uM=nanmedian(reshape(dm_in_KB_R10uM,[1,numel(dm_in_KB_R10uM)]));
for i=1:size(dm_Pre_D2,1)
    index=find(dm_Pre_D2(i,:)<thresh);
    dm_Pre_D2(i,index)=0;
    dmsum_Pre_D2(i)=cmpp*nansum(dm_Pre_D2(i,:));
end

dm_in_D2=[];
for i=1:length(filenames_in_baseline{2})
    d=load(filenames_in_baseline{2}(i).name);
    dm_in_D2=[dm_in_D2;d.dm(:,1:nframes)];
end
%Median_dm_in_KB_R10uM=nanmedian(reshape(dm_in_KB_R10uM,[1,numel(dm_in_KB_R10uM)]));
for i=1:size(dm_in_D2,1)
    index=find(dm_in_D2(i,:)<thresh);
    dm_in_D2(i,index)=0;
    dmsum_in_D2(i)=cmpp*nansum(dm_in_D2(i,:));
end
if ~isempty(filenames_2h_baseline{2})
    dm_2h_D2=[];
    for i=1:length(filenames_2h_baseline{2}(i).name)
        d=load(filenames_2h_baseline{2}(i).name);
        dm_2h_D2=[dm_2h_D2;d.dm(:,1:nframes)];
    end
    %Median_dm_2h_KB_R10uM=nanmedian(reshape(dm_2h_KB_R10uM,[1,numel(dm_2h_KB_R10uM)]));
    for i=1:size(dm_2h_D2,1)
        index=find(dm_2h_D2(i,:)<thresh);
        dm_2h_D2(i,index)=0;
        dmsum_2h_D2(i)=cmpp*nansum(dm_2h_D2(i,:));
    end
end

if ~isempty(filenames_5h_baseline{2})
    dm_5h_D2=[];
    for i=1:length(filenames_5h_baseline{2})
        d=load(filenames_5h_baseline{2}(i).name);
        dm_5h_D2=[dm_5h_D2;d.dm(:,1:nframes)];
    end
    for i=1:size(dm_5h_D2,1)
        index=find(dm_5h_D2(i,:)<thresh);
        dm_5h_D2(i,index)=0;
        dmsum_5h_D2(i)=cmpp*nansum(dm_5h_D2(i,:));
    end
end

%%

All_dmsum=[dmsum_Pre_D2,dmsum_5h_D2];
All_dmsum_groups=[ones(size(dmsum_Pre_D2)),2*ones(size(dmsum_5h_D2))]
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(strcat(Drugs{2},'-5h Recover'))

multcompare(STATS)

All_dmsum=[dmsum_Pre_D2,dmsum_in_D2];
All_dmsum_groups=[ones(size(dmsum_Pre_D2)),2*ones(size(dmsum_in_D2))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(strcat(Drugs{2},'-90minTreatment'))

figure
multcompare(STATS)

All_dmsum=[dmsum_Pre_D1,dmsum_in_D2,dmsum_5h_D2];
All_dmsum_groups=[ones(size(dmsum_Pre_D1)),2*ones(size(dmsum_in_D2)),3*ones(size(dmsum_5h_D2))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(Drugs{2})
figure
multcompare(STATS)


%% merge plots for the two drugs
All_dmsum=[dmsum_5h_C,dmsum_5h_D1,dmsum_5h_D2];
All_dmsum_groups=[ones(size(dmsum_5h_C)),2*ones(size(dmsum_5h_D1)),3*ones(size(dmsum_5h_D2))]
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(strcat('1=Control, 2= ', Drugs{1},',3= ',Drugs{2},'-5h Recover'))

All_dmsum=[dmsum_in_C,dmsum_in_D1,dmsum_in_D2];
All_dmsum_groups=[ones(size(dmsum_in_C)),2*ones(size(dmsum_in_D1)),3*ones(size(dmsum_in_D2))]
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(strcat('1=Control, 2= ', Drugs{1},',3= ',Drugs{2},'-Treatment'))


All_dmsum=[dmsum_in_C,dmsum_in_D1,dmsum_in_D2,dmsum_5h_C,dmsum_5h_D1,dmsum_5h_D2];
All_dmsum_groups=[ones(size(dmsum_in_C)),2*ones(size(dmsum_in_D1)),3*ones(size(dmsum_in_D2)),4*ones(size(dmsum_5h_C)),5*ones(size(dmsum_5h_D1)),6*ones(size(dmsum_5h_D2))]
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(strcat('1=Control, 2= ', Drugs{1},',3= ',Drugs{2},'-Treatment'))