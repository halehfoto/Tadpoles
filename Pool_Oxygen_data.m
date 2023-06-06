%pool Oxygen data for WB3.
d1=load('012023_firesting_x5tadpoles_WB3_WB25.mat');
d2=load('20230203_Oxygen_WB3_WB25.mat');
s=min(length(d1.WB3),length(d2.WB3));
Data_WB3=[d1.WB3(1:s,:)/100];
for i=1:size(Data_WB3,2)
    p = polyfit(d1.time(1:s)/3600,Data_WB3(:,i),1) 
    Slope_WB3(i)=p(1);%consumption rate per hour
end
Data_V=[d1.veh(1:s,:)/100];
for i=1:size(Data_V,2)
    p = polyfit(d1.time(1:s)/3600,Data_V(:,i),1) 
    Slope_V(i)=p(1);%consumption rate per hour
end

Data_WB25=[d1.WB25(1:s,:)/100];
for i=1:size(Data_WB25,2)
    p = polyfit(d1.time(1:s)/3600,Data_WB25(:,i),1) 
    Slope_WB25(i)=p(1);%consumption rate per hour
end

anova1([-1*Slope_V,-1*Slope_WB3],[ones(size(Slope_V)),2*ones(size(Slope_WB3))])
anova1([-1*Slope_V,-1*Slope_WB25],[ones(size(Slope_V)),2*ones(size(Slope_WB25))])

figure;stdshade(Data_V',0.1,'k',d1.time(1:s))
hold on
stdshade(Data_WB3',0.1,'r',d1.time(1:s))