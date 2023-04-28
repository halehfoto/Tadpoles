%this is a program that plots results from training experiments using Cog2
data1=readtable('day1_decisions.csv');
data2=readtable('day2_decisions.csv');
ntray=unique(data1.tray);
npool=unique(data1.pool);
ngroup=unique(data1.group)
C=[];
for i=1:length(data1.group)
    if contains(cell2mat(data1.group(i)),'C')
        C(i)=1;
    else
        C(i)=0;
    end
end
%plot results from the innate preference
for i=1:length(ngroup)
            index=find(sum(ismember(cell2mat(data1.group),ngroup{i}),2)==7&data1.stage==3& (data1.sumOf0~=0 |  data1.sumOf1~=0));
            decisions{i}=[data1.sumOf0(index);data1.sumOf1(index)];
            Groups{i}=[ones(size(data1.sumOf0(index)));2*ones(size(data1.sumOf1(index)))];
            kruskalwallis(decisions{i},Groups{i})
            title(ngroup{i}(end-1:end))
end
figure
for i=1:length(ngroup)
            index=find(sum(ismember(cell2mat(data1.group),ngroup{i}),2)==7&data1.stage==2& (data1.sumOf0~=0 |  data1.sumOf1~=0));
            decisions{i}=[data1.sumOf0(index);data1.sumOf1(index)];
            Groups{i}=[ones(size(data1.sumOf0(index)));2*ones(size(data1.sumOf1(index)))];
            subplot(1,4,i)
            hold on
            f=boxplot(decisions{i},Groups{i},'labels',{'L','R'})
            set(f,'LineWidth',1)
            title(ngroup{i}(end-1:end))
end

%compare back track or halt across training, pooling left and right groups
%together
All_data_C=[data1.sumOf2(C'==1 & data1.stage==0);data1.sumOf2(C'==1 & data1.stage==1);data1.sumOf2(C'==1 & data1.stage==2);data1.sumOf2(C'==1 & data1.stage==3)];
All_data_T=[data1.sumOf2(C'==0 & data1.stage==0);data1.sumOf2(C'==0 & data1.stage==1);data1.sumOf2(C'==0 & data1.stage==2);data1.sumOf2(C'==0 & data1.stage==3)];
Groups_C=[ones(size(data1.sumOf2(C'==1 & data1.stage==0)));2*ones(size(data1.sumOf2(C'==1 & data1.stage==1)));3*ones(size(data1.sumOf2(C'==1 & data1.stage==2)));4*ones(size(data1.sumOf2(C'==1 & data1.stage==3)))];
Groups_T=[ones(size(data1.sumOf2(C'==0 & data1.stage==0)));2*ones(size(data1.sumOf2(C'==0 & data1.stage==1)));3*ones(size(data1.sumOf2(C'==0 & data1.stage==2)));4*ones(size(data1.sumOf2(C'==0 & data1.stage==3)))];

[p,a,stats]=kruskalwallis(All_data_C,Groups_C);
figure
multcompare(stats)

[p,a,stats]=kruskalwallis(All_data_T,Groups_T);
figure
multcompare(stats)


