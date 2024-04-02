%convert2singleChannel.m

%imports multi-channel data and writes out selected single channel

%%%%%%%%%%%%%%%%%%
%CHANGE AS NEEDED

%Enter data folder
PATH2DATA = "D:\CBN_2022_10\AMAR819.1-2-3-4.32000";

%Enter output folder
PATH2OUTPUT = "D:\CBN_2022_10\AMAR819.3.32000"; 

%Enter desired channel
channel = 4;

%%%%%%%%%%%%%%%%%%
if ~exist(PATH2OUTPUT, 'dir')
   mkdir(PATH2OUTPUT)
end

filelist = dir(fullfile(PATH2DATA,'**/*.wav'));

for f = 1:length(filelist) 
    
    [x,Fs] = audioread(fullfile(filelist(f).folder,filelist(f).name));
    xinfo = audioinfo(fullfile(filelist(f).folder,filelist(f).name));
    BitsPerSample = xinfo.BitsPerSample;
    singleChannel = x(:,channel);
    
    temp = split(filelist(f).name,'.');
    SCFName = [char(temp(1)),'.',char(temp(2)),'.',num2str(channel),'.',char(temp(3))];
 
    audiowrite(fullfile(PATH2OUTPUT,SCFName),singleChannel,Fs,'BitsPerSample', BitsPerSample)
    
end