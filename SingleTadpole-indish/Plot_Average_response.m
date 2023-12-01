%this program generates a bar plot for average response rate on the first
%five reps of tap stimulus while under treatment.
clearvars
WC1_files=dir('*WC1*.mat');
WC22_files=dir('*WC22*.mat');
WB3_files=dir('*WB3*.mat');
Cont_files=dir('*_C_*.mat');

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

WC22=[];
WC22_rec=[];
for i=1:length(WC22_files)
    d=load(WC22_files(i).name);
     if contains(WC1_files(i).name,'Post')
         WC22_rec=[WC22_rec,nanmean(d.Resp(:,1:5),1)];

     else
         WC22=[WC22,nanmean(d.Resp(:,1:5),1)];
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
Data=[Cont,WC22,WC1,WB3,Cont_rec,WC22_rec,WC1_rec,WB3_rec];
Groups=[ones(size(Cont)),2*ones(size(WC22)),3*ones(size(WC1)),4*ones(size(WB3)),5*ones(size(Cont_rec)),6*ones(size(WC22_rec)),7*ones(size(WC1_rec)),8*ones(size(WB3_rec))];
[a,b,stats]=kruskalwallis(Data,Groups)
figure
r=multcompare(stats)

