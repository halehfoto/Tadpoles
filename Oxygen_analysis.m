%this program plots and characterizes oxygen data
%First import data the excel sheet from each treatment using the import
%button. save therelevant columns and give the names e.g. WB2=[cut and
%paste the columns etc. Also save a time vector 'time'. then save these
%three variables ina mat file. That mat file will be read by this program
clearvars
close all
path='\\research.files.med.harvard.edu\Wyss Institute\Levin Lab\Haleh';
cd(path)
path2=uigetdir;
cd(path2)
%read the video file
filename=uigetfile;
load(filename);
Drugs=input('Please enter drug names :')
time=time/60;
figure;
colors={'k','m','b'}
for i=1:length(Drugs)
    eval(['dataset=',Drugs{i},';'])
    dataset_norm=dataset./dataset(1,:);
    plot(time, mean(dataset_norm,2),'Color',colors{i},'LineWidth',1.5);
    hold on
    clear dataset
end

for i=1:length(Drugs)
    eval(['dataset=',Drugs{i},';'])
    dataset_norm=dataset./dataset(1,:);

    plot(time, mean(dataset_norm,2)+std(dataset_norm,[],2),':','Color',colors{i});
    hold on
    plot(time, mean(dataset_norm,2)-std(dataset_norm,[],2),':','Color',colors{i});   
    clear dataset;
end
legend(Drugs)

xlabel('Time (min)')
ylabel('Percent Oxygen')