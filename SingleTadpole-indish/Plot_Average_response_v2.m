%this program generates a bar plot for average response rate on the first
%five reps of tap stimulus while under treatment.
clearvars
WC1_files=dir('*WC1*.mat');
WB3_files=dir('*WB3*.mat');
Cont_files=dir('*_C_*.mat');
WB3_HClfiles=dir('*WB3HCL*.mat');
WB4_files=dir('*WB4_*.mat');
WB7_files=dir('*WB7*.mat');
WB36_files=dir('*WB36_*.mat');
WB36_1_files=dir('*WB36-1*.mat');
WB41_files=dir('*WB41_*.mat');
WB41_1_files=dir('*WB41-1*.mat');
WB68_1_files=dir('*WB68-1*.mat');
%Extract response probability for the first five trials for each treatment
WC1=[];
WC1_rec=[];
for i=1:length(WC1_files)
    d=load(WC1_files(i).name);                
    if contains(WC1_files(i).name,'Post')
        WC1_rec=[WC1_rec,nanmean(d.Resp(:,1:5),1)];
    else
        WC1=[WC1,nanmean(d.Resp(:,1:5),1)];
    end
end
WB3=[];
WB3_rec=[];
for i=1:length(WB3_files)
   d=load(WB3_files(i).name);
   if contains(WB3_files(i).name,'Post')
     WB3_rec=[WB3_rec,nanmean(d.Resp(:,1:5),1)];
   else
     WB3=[WB3,nanmean(d.Resp(:,1:5),1)];
   end
end
WB4=[];
WB4_rec=[];
for i=1:length(WB4_files)
   d=load(WB4_files(i).name);
   if contains(WB4_files(i).name,'Post')
     WB4_rec=[WB4_rec,nanmean(d.Resp(:,1:5),1)];
   else
     WB4=[WB4,nanmean(d.Resp(:,1:5),1)];
   end
end
WB3_HCl=[];
WB3_HCl_rec=[];
for i=1:length(WB3_HClfiles)
   d=load(WB3_HClfiles(i).name);
   if contains(WB3_HClfiles(i).name,'Post')
     WB3_HCl_rec=[WB3_HCl_rec,nanmean(d.Resp(:,1:5),1)];
   else
     WB3_HCl=[WB3_HCl,nanmean(d.Resp(:,1:5),1)];
   end
end
WB7=[];
WB7_rec=[];
for i=1:length(WB7_files)
   d=load(WB7_files(i).name);
   if contains(WB7_files(i).name,'Post')
     WB7_rec=[WB7_rec,nanmean(d.Resp(:,1:5),1)];
   else
     WB7=[WB7,nanmean(d.Resp(:,1:5),1)];
   end
end
WB36=[];
WB36_rec=[];
for i=1:length(WB36_files)
   d=load(WB36_files(i).name);
   if contains(WB36_files(i).name,'Post')
     WB36_rec=[WB36_rec,nanmean(d.Resp(:,1:5),1)];
   else
     WB36=[WB36,nanmean(d.Resp(:,1:5),1)];
   end
end
WB36_1=[];
WB36_1_rec=[];
for i=1:length(WB36_1_files)
   d=load(WB36_1_files(i).name);
   if contains(WB36_1_files(i).name,'Post')
     WB36_1_rec=[WB36_1_rec,nanmean(d.Resp(:,1:5),1)];
   else
     WB36_1=[WB36_1,nanmean(d.Resp(:,1:5),1)];
   end
end
WB41=[];
WB41_rec=[];
for i=1:length(WB41_files)
   d=load(WB41_files(i).name);
   if contains(WB41_files(i).name,'Post')
     WB41_rec=[WB41_rec,nanmean(d.Resp(:,1:5),1)];
   else
     WB41=[WB41,nanmean(d.Resp(:,1:5),1)];
   end
end
WB41_1=[];
WB41_1_rec=[];
for i=1:length(WB41_1_files)
   d=load(WB41_1_files(i).name);
   if contains(WB41_1_files(i).name,'Post')
     WB41_1_rec=[WB41_1_rec,nanmean(d.Resp(:,1:5),1)];
   else
     WB41_1=[WB41_1,nanmean(d.Resp(:,1:5),1)];
   end
end
WB68_1=[];
WB68_1_rec=[];
for i=1:length(WB68_1_files)
   d=load(WB68_1_files(i).name);
   if contains(WB68_1_files(i).name,'Post')
     WB68_1_rec=[WB68_1_rec,nanmean(d.Resp(:,1:5),1)];
   else
     WB68_1=[WB68_1,nanmean(d.Resp(:,1:5),1)];
   end
end


Cont=[];
Cont_rec=[];
for i=1:length(Cont_files)
    d=load(Cont_files(i).name);   
    if contains(Cont_files(i).name,'Post')
        Cont_rec=[Cont_rec,nanmean(d.Resp(:,1:5),1)];
    else
        Cont=[Cont,nanmean(d.Resp(:,1:5),1)];
    end
end

Data=[Cont,WB3,WB3_HCl,WB4, WB7,WB36,WB36_1,WB41, WB41_1, WB68_1,Cont_rec,WB3_rec,WB3_HCl_rec,WB4_rec, WB7_rec,WB36_rec,WB36_1_rec,WB41_rec, WB41_1_rec, WB68_1_rec];
Groups=[ones(size(Cont)),2*ones(size(WB3)),3*ones(size(WB3_HCl)),4*ones(size(WB4)),5*ones(size(WB7)),6*ones(size(WB36)),7*ones(size(WB36_1)),8*ones(size(WB41)), 9*ones(size(WB41_1)), 10*ones(size(WB68_1)),11*ones(size(Cont_rec)),12*ones(size(WB3_rec)),13*ones(size(WB3_HCl_rec)),14*ones(size(WB4_rec)),15*ones(size(WB7_rec)),16*ones(size(WB36_rec)),17*ones(size(WB36_1_rec)),18*ones(size(WB41_rec)), 19*ones(size(WB41_1_rec)), 20*ones(size(WB68_1_rec))];

[a,b,stats]=kruskalwallis(Data,Groups)
figure
r=multcompare(stats)
figure
%boxplot(Data,Groups,'Labels', ['V     ','WB3   ','WB3HCl','WB4   ','WB7','WB36','WB36-1','WB41','WB41-1','WB68-1','V_rec','WB3_rec','WB3HCl_rec','WB4_rec','WB7_rec','WB36_rec','WB36-1_rec','WB41_rec','WB41-1_rec','WB68-1_rec'])
boxplot(Data,Groups)

ylabel('Minimum movement index after treatment')

