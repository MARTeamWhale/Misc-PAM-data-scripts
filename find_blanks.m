%convert2singleChannel.m

%imports multi-channel data and writes out selected single channel

%%%%%%%%%%%%%%%%%%
%CHANGE AS NEEDED

%Enter data folder
%PATH2DATA = "\\142.2.83.52\whalenas1\MOORED_PAM_DATA\2018\09\LOC_2018_09\AMAR376.1.32000";

filelist = dir(fullfile(PATH2DATA,'**/*.wav'));
filetable = table(filelist);
nrow = size(filetable,1);
filetable.blank = zeros(nrow, 1); 


for f = 1:length(filelist) 
    tic
    [x,Fs] = audioread(fullfile(filelist(f).folder,filelist(f).name),[1,10]);
    if max(x) == 0
        filetable.blank(f) = 1;
    end
    toc
end