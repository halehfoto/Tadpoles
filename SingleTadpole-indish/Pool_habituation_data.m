%pool habituation data
clearvars
%close all
path=uigetdir;
cd(path)
filename=dir('*analyzed.mat');
repse=50;
for i=1:length(filename)
    data=load(filename(i).name,'resp_prob','ISI');
    ISI_Exp(i)=data.ISI;
    Trial_Count(i)=length(data.resp_prob);
    if numel(data.resp_prob)>=4* repse
        Resp_Prob_1(i,:)=data.resp_prob(1:repse);
        Resp_Prob_2(i,:)=data.resp_prob(repse+1:2*repse);
        Resp_Prob_3(i,:)=data.resp_prob(2*repse+1:3*repse);
        Resp_Prob_4(i,:)=data.resp_prob(3*repse+1:4*repse);

    elseif  numel(data.resp_prob)>=3* repse
         Resp_Prob_1(i,:)=data.resp_prob(1:repse);
         Resp_Prob_2(i,:)=data.resp_prob(repse+1:2*repse);
        Resp_Prob_3(i,:)=data.resp_prob(2*repse+1:3*repse);
        Resp_Prob_4(i,:)=NaN(size(Resp_Prob_1(i,:)));
    elseif   numel(data.resp_prob)>=2* repse
         Resp_Prob_1(i,:)=data.resp_prob(1:repse);
         Resp_Prob_2(i,:)=data.resp_prob(repse+1:2*repse);
         Resp_Prob_3(i,:)=NaN(size(Resp_Prob_1(i,:)));
         Resp_Prob_4(i,:)=NaN(size(Resp_Prob_1(i,:)));
    else
         Resp_Prob_1(i,:)=data.resp_prob(1:repse);
         Resp_Prob_2(i,:)==NaN(size(Resp_Prob_1(i,:)));
         Resp_Prob_3(i,:)=NaN(size(Resp_Prob_1(i,:)));
         Resp_Prob_4(i,:)=NaN(size(Resp_Prob_1(i,:)));


    end

end
color={'b','r','c'};
ISI=unique(ISI_Exp);
for i=1:length(ISI)
    figure;
    title(strcat('ISI=',num2str(ISI(i)),' s'));
    if sum(ISI_Exp==ISI(i))>1
%         plot(1:1:repse,nanmean(Resp_Prob_1(ISI_Exp==ISI(i),:)),'Color',color{i});
        f1=fit((1:1:repse)',(nanmean(Resp_Prob_1(ISI_Exp==ISI(i),:)))','exp1');
        plot(f1,(1:1:repse)',(nanmean(Resp_Prob_1(ISI_Exp==ISI(i),:)))');hold on
        f2=fit((repse+20+1:1:2*repse+20)',(nanmean(Resp_Prob_2(ISI_Exp==ISI(i),:)))','exp1');
        plot(f2,(repse+20+1:1:2*repse+20)',(nanmean(Resp_Prob_2(ISI_Exp==ISI(i),:)))');
        f3=fit((2*repse+40+1:1:3*repse+40)',(nanmean(Resp_Prob_3(ISI_Exp==ISI(i),:)))','exp1');
        plot(f3,(2*repse+40+1:1:3*repse+40)',(nanmean(Resp_Prob_3(ISI_Exp==ISI(i),:)))');
        f4=fit((3*repse+60+1:1:4*repse+60)',(nanmean(Resp_Prob_4(ISI_Exp==ISI(i),:)))','exp1');
        plot(f4,(3*repse+60+1:1:4*repse+60)',(nanmean(Resp_Prob_4(ISI_Exp==ISI(i),:)))');
 
%         %plot(repse+20+1:1:2*repse+20,nanmean(Resp_Prob_2(ISI_Exp==ISI(i),:)),'Color',color{i});
%         plot(2*repse+40+1:1:3*repse+40,nanmean(Resp_Prob_3(ISI_Exp==ISI(i),:)),'Color',color{i});
%         plot(3*repse+60+1:1:4*repse+60,nanmean(Resp_Prob_4(ISI_Exp==ISI(i),:)),'Color',color{i});

    else
        plot(1:1:repse,Resp_Prob_1(i,:),'Color',color{i});
        hold on
        plot(repse+20+1:1:2*repse+20,(Resp_Prob_2(ISI_Exp==ISI(i),:)),'Color',color{i});
        plot(2*repse+40+1:1:3*repse+40,(Resp_Prob_3(ISI_Exp==ISI(i),:)),'Color',color{i});
        plot(3*repse+60+1:1:4*repse+60,(Resp_Prob_4(ISI_Exp==ISI(i),:)),'Color',color{i});
    end
end
