%this program plots and characterizes oxygen data
clearvars
close all
path='\\research.files.med.harvard.edu\Wyss Institute\Levin Lab\Haleh';
cd(path)
path2=uigetdir;
cd(path2)
%read the video file
filename=uigetfile;
load(filename);
Drugs=input('Please enter drug names in quotaions and comma separated in the same order as well numbers:')
time=time/60;
figure;
colors={'k','m','b'}
for i=1:length(Drugs)
    eval(['dataset=',Drugs{i},';'])
    plot(time, mean(dataset,2),'Color',colors{i},'LineWidth',1.5);
    hold on
    clear dataset
end

for i=1:length(Drugs)
    eval(['dataset=',Drugs{i},';'])
    plot(time, mean(dataset,2)+std(dataset,[],2),':','Color',colors{i});
    hold on
    plot(time, mean(dataset,2)-std(dataset,[],2),':','Color',colors{i});   
    clear dataset;
end
legend(Drugs)

xlabel('Time (min)')
ylabel('Percent Oxygen')