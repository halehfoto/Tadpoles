%this is a program that pools data from different experiments with similar
%treatments.
clearvars
close all
path='\\files.med.harvard.edu\Wyss Institute\Levin Lab\Haleh\Biostasis paper';
cd(path)
path2=uigetdir;
cd(path2)
filenames=dir('*.mat');
for i=1:length(filenames)
    d=load(filenames(i).name);
    d.Drugs
end