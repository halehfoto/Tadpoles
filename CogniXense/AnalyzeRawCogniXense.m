%this is a program to go through csv files generated by the cognixense
%system
path=uigetdir('C:\Users\Haleh\OneDrive - Harvard University\Documents\Tadpole Data\Cognixense\Haleh/');
cd(path)
filenames=dir('*.csv');
data=xlsread(filenames(1).name);
index0=find(data(:,4)==0,1)
index1=find(data(:,4)==1,1)
index2=find(data(:,4)==2,1)
index3=find(data(:,4)==3,1)
index4=find(data(:,4)==4,1)
date0 = datestr(data(index0,1)/86400 + datenum(1970,1,1))
date1 = datestr(data(index1,1)/86400 + datenum(1970,1,1))
date2 = datestr(data(index2,1)/86400 + datenum(1970,1,1))
date3 = datestr(data(index3,1)/86400 + datenum(1970,1,1))
date4 = datestr(data(index4,1)/86400 + datenum(1970,1,1))