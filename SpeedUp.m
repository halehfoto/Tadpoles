%this is a program that opens a video and saves a downsampled version of
%it.
clearvars
close all
path='\\research.files.med.harvard.edu\Wyss Institute\Levin Lab\Haleh';
speedup=input('please enter how much you like to speed up the video, e.g. for 10 times enter 10:') 
cd(path)
filename=uigetfile;
v=VideoReader(filename);
T0=v.CurrentTime;
fps=v.Framerate;
