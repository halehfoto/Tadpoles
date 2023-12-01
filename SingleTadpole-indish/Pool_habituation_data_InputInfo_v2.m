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
filenames_Pre_C=dir(strcat('*_C_*_Pre',stimstr,'_analyzed.mat'));
filenames_in_C=dir(strcat('*_C_*_In',stimstr,'_analyzed.mat'));
filenames_2h_C=dir(strcat('*_C_*_2h_Post',stimstr,'_analyzed.mat'));
filenames_3h_C=dir(strcat('*_C_*_3h_Post',stimstr,'_analyzed.mat'));
filenames_5h_C=dir(strcat('*_C_*_5h_Post',stimstr,'_analyzed.mat'));
filenames_7h_C=dir(strcat('*_C_*_7h_Post',stimstr,'_analyzed.mat'));

fn_baseline_C=dir(strcat('*_C_*_Pre_baseline',stimstr,'_analyzed.mat'));
fn_baseline_in_C=dir(strcat('*_C_*_In*_baseline',stimstr,'_analyzed.mat'));
fn_baseline_2h_C=dir(strcat('*_C_*_2h_Post_baseline',stimstr,'_analyzed.mat'));
fn_baseline_3h_C=dir(strcat('*_C_*_3h_Post_baseline',stimstr,'_analyzed.mat'));
fn_baseline_7h_C=dir(strcat('*_C_*_5h_Post_baseline',stimstr,'_analyzed.mat'));

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

end


%% analyze control 1
if ~isempty(filenames_in_C)

    Resp_Pre_C=[];
    for i=1:length(filenames_Pre_C)
        d=load(filenames_Pre_C(i).name);
        if size(d.Resp,2)<20
            temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
        else
            temp=d.Resp(:,1:20);
        end

        Resp_Pre_C=[Resp_Pre_C;temp];
    end
    Resp_in_C=[];
    for i=1:length(filenames_in_C)
        d=load(filenames_in_C(i).name);
        if size(d.Resp,2)<20
            temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
        else
            temp=d.Resp(:,1:20);
        end

        Resp_in_C=[Resp_in_C;temp];
    end

    Resp_2h_C=[];
    for i=1:length(filenames_2h_C)
        d=load(filenames_2h_C(i).name);
        if size(d.Resp,2)<20
            temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
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
    if sum(isnan(resp_prob_Pre_C))==0
        L=21;
    else
        L=find(isnan(resp_prob_Pre_C),1);
    end
    

    figure;title('Control'); plot(resp_prob_Pre_C(1:L-1),'*');hold on
    f=fit((1:1:L-1)',(resp_prob_Pre_C(1:L-1))','exp1');plot(f,(1:1:L-1)',(resp_prob_Pre_C(1:L-1))')

    if Stim_In
        resp_prob_in_C=nanmean(Resp_in_C,1);
        if sum(isnan(resp_prob_in_C))==0
            L=21;
        else
            L=find(isnan(resp_prob_in_C),1);
        end

        plot((21:1:20+L-1)',resp_prob_in_C(1:L-1),'*');hold on
        f=fit((21:1:20+L-1)',(resp_prob_in_C(1:L-1))','exp1');plot(f,(21:1:20+L-1)',(resp_prob_in_C(1:L-1))')
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
end
%% do the same for the drugs


Resp_Pre_D1=[];
for i=1:length(filenames_Pre{1})
    d=load(filenames_Pre{1}(i).name);
    if size(d.Resp,2)<20
        temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
    else
        temp=d.Resp(:,1:20);
    end
                
    Resp_Pre_D1=[Resp_Pre_D1;temp];
end
Resp_in_D1=[];
for i=1:length(filenames_in{1})
    d=load(filenames_in{1}(i).name);
    if size(d.Resp,2)<20
        temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
    else
        temp=d.Resp(:,1:20);
    end

    Resp_in_D1=[Resp_in_D1;temp];
end
Resp_2h_D1=[];
for i=1:length(filenames_2h{1})
    d=load(filenames_2h{1}(i).name);
    if size(d.Resp,2)<20
        temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
    else
        temp=d.Resp(:,1:20);
    end

    Resp_2h_D1=[Resp_2h_D1;temp];
end

Resp_3h_D1=[];
for i=1:length(filenames_3h{1})
    d=load(filenames_3h{1}(i).name);
    if size(d.Resp,2)<20
        temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
    else
        temp=d.Resp(:,1:20);
    end

    Resp_3h_D1=[Resp_3h_D1;temp];
end
Resp_5h_D1=[];
for i=1:length(filenames_5h{1})
    d=load(filenames_5h{1}(i).name);
    if size(d.Resp,2)<20
        temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
    else
        temp=d.Resp(:,1:20);
    end

    Resp_5h_D1=[Resp_5h_D1;temp];
end

resp_prob_Pre_D1=nanmean(Resp_Pre_D1,1);
figure;title('Control'); plot(resp_prob_Pre_D1,'*');hold on
if sum(isnan(resp_prob_Pre_D1))==0
    L=21;
else
    L=find(isnan(resp_prob_Pre_D1),1);
end
    
f=fit((1:L-1)',(resp_prob_Pre_D1(1:L-1))','exp1');plot(f,(1:1:L-1)',(resp_prob_Pre_D1(1:L-1))')
% if sum(isnan(resp_prob_in_D1))==0
%     L=21;
% else
%     L=find(isnan(resp_prob_in_D1),1);
% end
% 
if Stim_In
    resp_prob_in_D1=nanmean(Resp_in_D1,1);
    if sum(isnan( resp_prob_in_D1))==0
        L=21;
    else
        L=find(isnan( resp_prob_in_D1),1);
    end

    plot((21:1:20+L-1)',resp_prob_in_D1(1:L-1),'*');hold on
    f=fit((21:1:20+L-1)',(resp_prob_in_D1(1:L-1))','exp1');plot(f,(21:1:20+L-1)',(resp_prob_in_D1(1:L-1))')
end


if ~isempty(Resp_2h_D1)
    resp_prob_2h_D1=nanmean(Resp_2h_D1,1);
    if sum(isnan(resp_prob_2h_D1))==0
        L=21;
    else
        L=find(isnan(resp_prob_2h_D1),1);
    end

    plot((41:1:40+L-1)',resp_prob_2h_D1(1:L-1),'*');hold on
    f=fit((41:1:40+L-1)',(resp_prob_2h_D1(1:L-1))','exp1');plot(f,(41:1:40+L-1)',(resp_prob_2h_D1(1:L-1))')
end
if ~isempty(Resp_3h_D1)
   resp_prob_3h_D1=nanmean(Resp_3h_D1,1);

    if sum(isnan(resp_prob_3h_D1))==0
        L=21;
    else
        L=find(isnan(resp_prob_3h_D1),1);
    end

    plot((61:1:60+L-1)',resp_prob_3h_D1(1:L-1),'*');hold on
    f=fit((61:1:60+L-1)',(resp_prob_3h_D1(1:L-1))','exp1');plot(f,(61:1:60+L-1)',(resp_prob_3h_D1(1:L-1))')

end
if ~isempty(Resp_5h_D1)
    resp_prob_5h_D1=nanmean(Resp_5h_D1,1);
    plot((81:1:100)',resp_prob_5h_D1,'*');hold on
    f=fit((81:1:100)',(resp_prob_5h_D1)','exp1');plot(f,(81:1:100)',(resp_prob_5h_D1)')
end

legend 'off'
ylim([0,1]);
title(Drugs{1})
xlabel('trials')
ylabel('startle probability')

%% do the same for D2

if length(Drugs)>1
    Resp_Pre_D2=[];
    for i=1:length(filenames_Pre{2})
        d=load(filenames_Pre{2}(i).name);
        if size(d.Resp,2)<20
            temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
        else
            temp=d.Resp(:,1:20);
        end
        
        Resp_Pre_D2=[Resp_Pre_D2;temp];
    end
    
    if Stim_In
        Resp_in_D2=[];
        for i=1:length(filenames_in{2})
            d=load(filenames_in{2}(i).name);
            if size(d.Resp,2)<20
                temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
            else
                temp=d.Resp(:,1:20);
            end

            Resp_in_D2=[Resp_in_D2;temp];
        end
    end
    
    Resp_2h_D2=[];
    for i=1:length(filenames_2h{2})
        d=load(filenames_2h{2}(i).name);
        if size(d.Resp,2)<20
            temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
        else
            temp=d.Resp(:,1:20);
        end
        Resp_2h_D2=[Resp_2h_D2;temp];
        
    end
    
    Resp_3h_D2=[];
    for i=1:length(filenames_3h{2})
        d=load(filenames_3h{2}(i).name);
        if size(d.Resp,2)<20
            temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
        else
            temp=d.Resp(:,1:20);
        end

        Resp_3h_D2=[Resp_3h_D2;temp];
    end
    Resp_5h_D2=[];
    for i=1:length(filenames_5h{2})
        d=load(filenames_5h{2}(i).name);
        if size(d.Resp,2)<20
            temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
        else
            temp=d.Resp(:,1:20);
        end

        Resp_5h_D2=[Resp_5h_D2;temp];
    end
    
    
    resp_prob_Pre_D2=nanmean(Resp_Pre_D2,1);
    if sum(isnan(resp_prob_Pre_D2))==0
        L=21;
    else
        L=find(isnan(resp_prob_Pre_D2),1);
    end

    figure;title('Control'); plot(resp_prob_Pre_D2,'*');hold on
    f=fit((1:1:L-1)',(resp_prob_Pre_D2(1:L-1))','exp1');plot(f,(1:1:L-1)',(resp_prob_Pre_D2(1:L-1))')
    
    if Stim_In
        resp_prob_in_D2=nanmean(Resp_in_D2,1);
        if sum(isnan(resp_prob_in_D2))==0
            L=21;
        else
            L=find(isnan(resp_prob_in_D2),1);
        end

        plot((21:1:20+L-1)',resp_prob_in_D2(1:L-1),'*');hold on
        f=fit((21:1:20+L-1)',(resp_prob_in_D2(1:L-1))','exp1');plot(f,(21:1:20+L-1)',(resp_prob_in_D2((1:L-1)))')
    end
    if ~isempty(Resp_2h_D2)
        resp_prob_2h_D2=nanmean(Resp_2h_D2,1);
        if sum(isnan(resp_prob_2h_D2))==0
            L=21;
        else
            L=find(isnan(resp_prob_2h_D2),1);
        end

        plot((41:1:40+L-1)',resp_prob_2h_D2(1:L-1),'*');hold on
        f=fit((41:1:40+L-1)',(resp_prob_2h_D2(1:L-1))','exp1');plot(f,(41:1:40+L-1)',(resp_prob_2h_D2(1:L-1))')
    end
    if ~isempty(Resp_3h_D2)
        resp_prob_3h_D2=nanmean(Resp_3h_D2,1);
        
        if sum(isnan(resp_prob_3h_D2))==0
            L=21;
        else
            L=find(isnan(resp_prob_3h_D2),1);
        end

        plot((61:1:60+L-1)',resp_prob_3h_D2(1:L-1),'*');hold on
        f=fit((61:1:60+L-1)',(resp_prob_3h_D2(1:L-1))','exp1');plot(f,(61:1:60+L-1)',(resp_prob_3h_D2(1:L-1))')
    end
    
    if ~isempty(Resp_5h_D2)
        resp_prob_5h_D2=nanmean(Resp_5h_D2,1);
        plot((81:1:100)',resp_prob_5h_D2,'*');hold on
        f=fit((81:1:100)',(resp_prob_5h_D2)','exp1');plot(f,(81:1:100)',(resp_prob_5h_D2)')
    end
    
    legend 'off'
    ylim([0,1]);
    title(Drugs{2})
    xlabel('trials')
    ylabel('startle probability')
end
%% Do the same for D3

if length(Drugs)>1
    Resp_Pre_D3=[];
    for i=1:length(filenames_Pre{3})
        d=load(filenames_Pre{3}(i).name);
        if size(d.Resp,2)<20
            temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
        else
            temp=d.Resp(:,1:20);
        end
        
        Resp_Pre_D3=[Resp_Pre_D3;temp];
    end
    
    if Stim_In
        Resp_in_D3=[];
        for i=1:length(filenames_in{3})
            d=load(filenames_in{3}(i).name);
            if size(d.Resp,2)<20
                temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
            else
                temp=d.Resp(:,1:20);
            end

            Resp_in_D3=[Resp_in_D3;temp];
        end
    end
    
    Resp_2h_D3=[];
    for i=1:length(filenames_2h{3})
        d=load(filenames_2h{3}(i).name);
        if size(d.Resp,2)<20
            temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
        else
            temp=d.Resp(:,1:20);
        end
        Resp_2h_D3=[Resp_2h_D3;temp];
        
    end
    
    Resp_3h_D3=[];
    for i=1:length(filenames_3h{3})
        d=load(filenames_3h{3}(i).name);
        if size(d.Resp,2)<20
            temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
        else
            temp=d.Resp(:,1:20);
        end

        Resp_3h_D3=[Resp_3h_D3;temp];
    end
    Resp_5h_D3=[];
    for i=1:length(filenames_5h{3})
        d=load(filenames_5h{3}(i).name);
        if size(d.Resp,2)<20
            temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
        else
            temp=d.Resp(:,1:20);
        end

        Resp_5h_D3=[Resp_5h_D3;temp];
    end
    
    
    resp_prob_Pre_D3=nanmean(Resp_Pre_D3,1);
    if sum(isnan(resp_prob_Pre_D3))==0
        L=21;
    else
        L=find(isnan(resp_prob_Pre_D3),1);
    end

    figure;title('Control'); plot(resp_prob_Pre_D3,'*');hold on
    f=fit((1:1:L-1)',(resp_prob_Pre_D3(1:L-1))','exp1');plot(f,(1:1:L-1)',(resp_prob_Pre_D3(1:L-1))')
    
    if Stim_In
        resp_prob_in_D3=nanmean(Resp_in_D3,1);
        if sum(isnan(resp_prob_in_D3))==0
            L=21;
        else
            L=find(isnan(resp_prob_in_D3),1);
        end

        plot((21:1:20+L-1)',resp_prob_in_D3(1:L-1),'*');hold on
        f=fit((21:1:20+L-1)',(resp_prob_in_D3(1:L-1))','exp1');plot(f,(21:1:20+L-1)',(resp_prob_in_D3((1:L-1)))')
    end
    if ~isempty(Resp_2h_D3)
        resp_prob_2h_D3=nanmean(Resp_2h_D3,1);
        if sum(isnan(resp_prob_2h_D3))==0
            L=21;
        else
            L=find(isnan(resp_prob_2h_D3),1);
        end

        plot((41:1:40+L-1)',resp_prob_2h_D3(1:L-1),'*');hold on
        f=fit((41:1:40+L-1)',(resp_prob_2h_D3(1:L-1))','exp1');plot(f,(41:1:40+L-1)',(resp_prob_2h_D3(1:L-1))')
    end
    if ~isempty(Resp_3h_D3)
        resp_prob_3h_D3=nanmean(Resp_3h_D3,1);
        if sum(isnan(resp_prob_3h_D3))==0
            L=21;
        else
            L=find(isnan(resp_prob_3h_D3),1);
        end

        plot((61:1:60+L-1)',resp_prob_3h_D3(1:L-1),'*');hold on
        f=fit((61:1:60+L-1)',(resp_prob_3h_D3(1:L-1))','exp1');plot(f,(61:1:60+L-1)',(resp_prob_3h_D3(1:L-1))')
    end
    
    if ~isempty(Resp_5h_D3)
        resp_prob_5h_D3=nanmean(Resp_5h_D3,1);
        plot((81:1:100)',resp_prob_5h_D3,'*');hold on
        f=fit((81:1:100)',(resp_prob_5h_D3)','exp1');plot(f,(81:1:100)',(resp_prob_5h_D3)')
    end
    
    legend 'off'
    ylim([0,1]);
    title(Drugs{3})
    xlabel('trials')
    ylabel('startle probability')
end
%% Do the same for D4

if length(Drugs)>1
    Resp_Pre_D4=[];
    for i=1:length(filenames_Pre{4})
        d=load(filenames_Pre{4}(i).name);
        if size(d.Resp,2)<20
            temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
        else
            temp=d.Resp(:,1:20);
        end
        
        Resp_Pre_D4=[Resp_Pre_D4;temp];
    end
    
    if Stim_In
        Resp_in_D4=[];
        for i=1:length(filenames_in{4})
            d=load(filenames_in{4}(i).name);
            if size(d.Resp,2)<20
                temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
            else
                temp=d.Resp(:,1:20);
            end

            Resp_in_D4=[Resp_in_D4;temp];
        end
    end
    
    Resp_2h_D4=[];
    for i=1:length(filenames_2h{4})
        d=load(filenames_2h{4}(i).name);
        if size(d.Resp,2)<20
            temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
        else
            temp=d.Resp(:,1:20);
        end
        Resp_2h_D4=[Resp_2h_D4;temp];
        
    end
    
    Resp_3h_D4=[];
    for i=1:length(filenames_3h{4})
        d=load(filenames_3h{4}(i).name);
        if size(d.Resp,2)<20
            temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
        else
            temp=d.Resp(:,1:20);
        end

        Resp_3h_D4=[Resp_3h_D4;temp];
    end
    Resp_5h_D4=[];
    for i=1:length(filenames_5h{4})
        d=load(filenames_5h{4}(i).name);
        if size(d.Resp,2)<20
            temp=[d.Resp,NaN(20,20-size(d.Resp,2))];
        else
            temp=d.Resp(:,1:20);
        end

        Resp_5h_D4=[Resp_5h_D4;temp];
    end
    
    
    resp_prob_Pre_D4=nanmean(Resp_Pre_D4,1);
    if sum(isnan(resp_prob_Pre_D4))==0
        L=21;
    else
        L=find(isnan(resp_prob_Pre_D4),1);
    end

    figure;title('Control'); plot(resp_prob_Pre_D4,'*');hold on
    f=fit((1:1:L-1)',(resp_prob_Pre_D4(1:L-1))','exp1');plot(f,(1:1:L-1)',(resp_prob_Pre_D4(1:L-1))')
    
    if Stim_In
        resp_prob_in_D4=nanmean(Resp_in_D4,1);
        if sum(isnan(resp_prob_in_D4))==0
            L=21;
        else
            L=find(isnan(resp_prob_in_D4),1);
        end

        plot((21:1:20+L-1)',resp_prob_in_D4(1:L-1),'*');hold on
        f=fit((21:1:20+L-1)',(resp_prob_in_D4(1:L-1))','exp1');plot(f,(21:1:20+L-1)',(resp_prob_in_D4((1:L-1)))')
    end
    if ~isempty(Resp_2h_D4)
        resp_prob_2h_D4=nanmean(Resp_2h_D4,1);
        if sum(isnan(resp_prob_2h_D4))==0
            L=21;
        else
            L=find(isnan(resp_prob_2h_D4),1);
        end

        plot((41:1:40+L-1)',resp_prob_2h_D4(1:L-1),'*');hold on
        f=fit((41:1:40+L-1)',(resp_prob_2h_D4(1:L-1))','exp1');plot(f,(41:1:40+L-1)',(resp_prob_2h_D4(1:L-1))')
    end
    if ~isempty(Resp_3h_D4)
        resp_prob_3h_D4=nanmean(Resp_3h_D4,1);
        if sum(isnan(resp_prob_3h_D4))==0
            L=21;
        else
            L=find(isnan(resp_prob_3h_D4),1);
        end

        plot((61:1:60+L-1)',resp_prob_3h_D4(1:L-1),'*');hold on
        f=fit((61:1:60+L-1)',(resp_prob_3h_D4(1:L-1))','exp1');plot(f,(61:1:60+L-1)',(resp_prob_3h_D4(1:L-1))')
    end
    
    if ~isempty(Resp_5h_D4)
        resp_prob_5h_D4=nanmean(Resp_5h_D4,1);
        plot((81:1:100)',resp_prob_5h_D4,'*');hold on
        f=fit((81:1:100)',(resp_prob_5h_D4)','exp1');plot(f,(81:1:100)',(resp_prob_5h_D4)')
    end
    
    legend 'off'
    ylim([0,1]);
    title(Drugs{4})
    xlabel('trials')
    ylabel('startle probability')
end
%% compare baseline activities
%control 1
thresh=0.5
minutes=5;
nframes=fps*60*minutes;
cmpp=0.03/minutes;%scaling factor to get movement in cm per minute
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

dm_3h_C=[];
for i=1:length(fn_baseline_3h_C)
    d=load(fn_baseline_3h_C(i).name);
    dm_3h_C=[dm_3h_C;d.dm(:,1:nframes)];
end
%Median_dm_in_C120=nanmedian(reshape(dm_in_C120,[1,numel(dm_in_C120)]));
for i=1:size(dm_3h_C,1)
    index=find(dm_3h_C(i,:)<thresh);
    dm_3h_C(i,index)=0;
    dmsum_3h_C(i)=cmpp*nansum(dm_3h_C(i,:));
end
All_dmsum=[dmsum_Pre_C,dmsum_in_C,dmsum_3h_C];
All_dmsum_groups=[ones(size(dmsum_Pre_C)),2*ones(size(dmsum_in_C)),3*ones(size(dmsum_3h_C))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title('Control')
figure
multcompare(STATS)

%% do the same for Drug 1

dm_Pre_D1=[];
for i=1:length(filenames_in_baseline{1})
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
    for i=1:length(filenames_2h_baseline{1})
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

if ~isempty(filenames_3h_baseline{1})
    dm_3h_D1=[];
    for i=1:length(filenames_3h_baseline{1})
        d=load(filenames_3h_baseline{1}(i).name);
        dm_3h_D1=[dm_3h_D1;d.dm(:,1:nframes)];
    end
    for i=1:size(dm_3h_D1,1)
        index=find(dm_3h_D1(i,:)<thresh);
        dm_3h_D1(i,index)=0;
        dmsum_3h_D1(i)=cmpp*nansum(dm_3h_D1(i,:));
    end
end



All_dmsum=[dmsum_Pre_D1,dmsum_3h_D1];
All_dmsum_groups=[ones(size(dmsum_Pre_D1)),2*ones(size(dmsum_3h_D1))]
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(strcat(Drugs{1},'-3h Recover'))

multcompare(STATS)

All_dmsum=[dmsum_Pre_D1,dmsum_in_D1];
All_dmsum_groups=[ones(size(dmsum_Pre_D1)),2*ones(size(dmsum_in_D1))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(strcat(Drugs{1},'-60minTreatment'))

% All_dmsum=[dmsum_Pre_D1,dmsum_in_D1,dmsum_2h_D1];
% All_dmsum_groups=[ones(size(dmsum_Pre_D1)),2*ones(size(dmsum_in_D1)),3*ones(size(dmsum_2h_D1))];
% [a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
% title(strcat(Drugs{1},'-300minTreatment, 2h recovery'))
% figure
% [c,m,h,nms]=multcompare(STATS)

All_dmsum=[dmsum_Pre_D1,dmsum_in_D1,dmsum_3h_D1];
All_dmsum_groups=[ones(size(dmsum_Pre_D1)),2*ones(size(dmsum_in_D1)),3*ones(size(dmsum_3h_D1))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(Drugs{1})
figure
multcompare(STATS)

%% do the same for drug 2

dm_Pre_D2=[];
for i=1:length(filenames_in_baseline{2})
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
    for i=1:length(filenames_2h_baseline{2})
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

if ~isempty(filenames_3h_baseline{2})
    dm_3h_D2=[];
    for i=1:length(filenames_3h_baseline{2})
        d=load(filenames_3h_baseline{2}(i).name);
        dm_3h_D2=[dm_3h_D2;d.dm(:,1:nframes)];
    end
    for i=1:size(dm_3h_D2,1)
        index=find(dm_3h_D2(i,:)<thresh);
        dm_3h_D2(i,index)=0;
        dmsum_3h_D2(i)=cmpp*nansum(dm_3h_D2(i,:));
    end
end



All_dmsum=[dmsum_Pre_D2,dmsum_3h_D2];
All_dmsum_groups=[ones(size(dmsum_Pre_D2)),2*ones(size(dmsum_3h_D2))]
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(strcat(Drugs{2},'-3h Recover'))

multcompare(STATS)

All_dmsum=[dmsum_Pre_D2,dmsum_in_D2,dmsum_3h_D2];
All_dmsum_groups=[ones(size(dmsum_Pre_D2)),2*ones(size(dmsum_in_D2)),3*ones(size(dmsum_3h_D2))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(strcat(Drugs{2},'-90minTreatment'))

figure
multcompare(STATS)

% All_dmsum=[dmsum_Pre_D2,dmsum_in_D2,dmsum_2h_D2];
% All_dmsum_groups=[ones(size(dmsum_Pre_D1)),2*ones(size(dmsum_in_D2)),3*ones(size(dmsum_2h_D2))];
% [a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
% title(strcat(Drugs{2},'-300minTreatment, 2h recovery'))
% figure
% [c,m,h,nms]=multcompare(STATS)

%% %% do the same for drug 3

dm_Pre_D3=[];
for i=1:length(filenames_in_baseline{1})
    d=load(filenames_Pre_baseline{3}(i).name);
    dm_Pre_D3=[dm_Pre_D3;d.dm(:,1:nframes)];
end
%Median_dm_in_KB_R10uM=nanmedian(reshape(dm_in_KB_R10uM,[1,numel(dm_in_KB_R10uM)]));
for i=1:size(dm_Pre_D3,1)
    index=find(dm_Pre_D3(i,:)<thresh);
    dm_Pre_D3(i,index)=0;
    dmsum_Pre_D3(i)=cmpp*nansum(dm_Pre_D3(i,:));
end

dm_in_D3=[];
for i=1:length(filenames_in_baseline{3})
    d=load(filenames_in_baseline{3}(i).name);
    dm_in_D3=[dm_in_D3;d.dm(:,1:nframes)];
end
%Median_dm_in_KB_R10uM=nanmedian(reshape(dm_in_KB_R10uM,[1,numel(dm_in_KB_R10uM)]));
for i=1:size(dm_in_D3,1)
    index=find(dm_in_D3(i,:)<thresh);
    dm_in_D3(i,index)=0;
    dmsum_in_D3(i)=cmpp*nansum(dm_in_D3(i,:));
end
if ~isempty(filenames_2h_baseline{3})
    dm_2h_D3=[];
    for i=1:length(filenames_2h_baseline{3})
        d=load(filenames_2h_baseline{3}(i).name);
        dm_2h_D3=[dm_2h_D3;d.dm(:,1:nframes)];
    end
    %Median_dm_2h_KB_R10uM=nanmedian(reshape(dm_2h_KB_R10uM,[1,numel(dm_2h_KB_R10uM)]));
    for i=1:size(dm_2h_D3,1)
        index=find(dm_2h_D3(i,:)<thresh);
        dm_2h_D3(i,index)=0;
        dmsum_2h_D3(i)=cmpp*nansum(dm_2h_D3(i,:));
    end
end

if ~isempty(filenames_3h_baseline{3})
    dm_3h_D3=[];
    for i=1:length(filenames_3h_baseline{3})
        d=load(filenames_3h_baseline{3}(i).name);
        dm_3h_D3=[dm_3h_D3;d.dm(:,1:nframes)];
    end
    for i=1:size(dm_3h_D3,1)
        index=find(dm_3h_D3(i,:)<thresh);
        dm_3h_D3(i,index)=0;
        dmsum_3h_D3(i)=cmpp*nansum(dm_3h_D3(i,:));
    end
end



All_dmsum=[dmsum_Pre_D3,dmsum_3h_D3];
All_dmsum_groups=[ones(size(dmsum_Pre_D3)),2*ones(size(dmsum_3h_D3))]
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(strcat(Drugs{3},'-3h Recover'))

multcompare(STATS)

All_dmsum=[dmsum_Pre_D3,dmsum_in_D3];
All_dmsum_groups=[ones(size(dmsum_Pre_D3)),2*ones(size(dmsum_in_D3))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(strcat(Drugs{3},'-100minTreatment'))

figure
multcompare(STATS)

All_dmsum=[dmsum_Pre_D3,dmsum_in_D3,dmsum_3h_D3];
All_dmsum_groups=[ones(size(dmsum_Pre_D1)),2*ones(size(dmsum_in_D3)),3*ones(size(dmsum_3h_D3))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(Drugs{3})
figure
multcompare(STATS)
%% Do the same for D4
dm_Pre_D4=[];
for i=1:length(filenames_in_baseline{1})
    d=load(filenames_Pre_baseline{4}(i).name);
    dm_Pre_D4=[dm_Pre_D4;d.dm(:,1:nframes)];
end
%Median_dm_in_KB_R10uM=nanmedian(reshape(dm_in_KB_R10uM,[1,numel(dm_in_KB_R10uM)]));
for i=1:size(dm_Pre_D4,1)
    index=find(dm_Pre_D4(i,:)<thresh);
    dm_Pre_D4(i,index)=0;
    dmsum_Pre_D4(i)=cmpp*nansum(dm_Pre_D4(i,:));
end

dm_in_D4=[];
for i=1:length(filenames_in_baseline{4})
    d=load(filenames_in_baseline{4}(i).name);
    dm_in_D4=[dm_in_D4;d.dm(:,1:nframes)];
end
%Median_dm_in_KB_R10uM=nanmedian(reshape(dm_in_KB_R10uM,[1,numel(dm_in_KB_R10uM)]));
for i=1:size(dm_in_D4,1)
    index=find(dm_in_D4(i,:)<thresh);
    dm_in_D4(i,index)=0;
    dmsum_in_D4(i)=cmpp*nansum(dm_in_D4(i,:));
end
if ~isempty(filenames_2h_baseline{4})
    dm_2h_D4=[];
    for i=1:length(filenames_2h_baseline{4})
        d=load(filenames_2h_baseline{4}(i).name);
        dm_2h_D4=[dm_2h_D4;d.dm(:,1:nframes)];
    end
    %Median_dm_2h_KB_R10uM=nanmedian(reshape(dm_2h_KB_R10uM,[1,numel(dm_2h_KB_R10uM)]));
    for i=1:size(dm_2h_D4,1)
        index=find(dm_2h_D4(i,:)<thresh);
        dm_2h_D4(i,index)=0;
        dmsum_2h_D4(i)=cmpp*nansum(dm_2h_D4(i,:));
    end
end

if ~isempty(filenames_3h_baseline{4})
    dm_3h_D4=[];
    for i=1:length(filenames_3h_baseline{4})
        d=load(filenames_3h_baseline{4}(i).name);
        dm_3h_D4=[dm_3h_D4;d.dm(:,1:nframes)];
    end
    for i=1:size(dm_3h_D4,1)
        index=find(dm_3h_D4(i,:)<thresh);
        dm_3h_D4(i,index)=0;
        dmsum_3h_D4(i)=cmpp*nansum(dm_3h_D4(i,:));
    end
end



All_dmsum=[dmsum_Pre_D4,dmsum_3h_D4];
All_dmsum_groups=[ones(size(dmsum_Pre_D4)),2*ones(size(dmsum_3h_D4))]
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(strcat(Drugs{4},'-3h Recover'))

multcompare(STATS)

All_dmsum=[dmsum_Pre_D4,dmsum_in_D4];
All_dmsum_groups=[ones(size(dmsum_Pre_D4)),2*ones(size(dmsum_in_D4))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(strcat(Drugs{4},'-100minTreatment'))

figure
multcompare(STATS)

All_dmsum=[dmsum_Pre_D4,dmsum_in_D4,dmsum_3h_D4];
All_dmsum_groups=[ones(size(dmsum_Pre_D1)),2*ones(size(dmsum_in_D4)),3*ones(size(dmsum_3h_D4))];
[a,b,STATS]=kruskalwallis(All_dmsum,All_dmsum_groups)
title(Drugs{4})
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
