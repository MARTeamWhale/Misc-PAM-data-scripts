%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to organize .wav files into subfolders by desired interval for the purpose of
% creating grouped LTSAs

    % Written by: J. Stanistreet, 19 February 2024 (MATLAB R2020a)
    % Last Updated by: Mike Adams, 13 May 2024 (MATLAB R2020a)
% DESCRIPTION:

    % Takes a deployment folder (directory of .wav files) as input, creates
    % subfolders of desired interval and moves .wav files into subfolders based on datetime in file name

% DEPENDENCIES:

    % MUCA.time.readDateTime
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Select directory (modify line 21)

% path to input .wav file directory (must end with \)
infilepath = 'D:\DAVIS_STRAIT_SoundTrap\DSC3_2020_09\Group_test\';

% Set desired interval
eventMergeOpt = 'calendar'; %%% Options are 'calendar', or 'timebin'
eventMergeVal = 'month'; %%% MATLAB duration object (timebin) or string (for calendar)

%% Set up

tic

% get list of wav file names
files = dir([infilepath '*.wav']);

% read datetime stamps from file names
filedate = MUCA.time.readDateTime({files.name})';

FirstDT = min(filedate);
LastDT = max(filedate);






% get unique year-month combinations and format as string for folder names
datetimes = unique(string(filedate));

% create monthly subfolders (mkdir function is not vectorized so have to use a loop here)
for ym = 1:length(datetimes)
    
    mkdir(fullfile(infilepath, datetimes(ym)));
    
end

%% Loop through files and move to monthly subfolders

for f = 1:length(files)
    
    % get full path to file
    fullfilepath = fullfile(infilepath, files(f).name);

    % get year and month of file (as string)
    f_folder = string(filedate(f)); 

    % get full path to correct month folder
    monthfolderpath = fullfile(infilepath, f_folder);
    
    % move file to month folder
    movefile(fullfilepath, monthfolderpath)
    
end
    
toc