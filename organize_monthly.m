%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to organize .wav files into subfolders by year and month for the purpose of
% creating monthly LTSAs

    % J. Stanistreet, 19 February 2024 (MATLAB R2020a)

% DESCRIPTION:

    % Takes a deployment folder (directory of .wav files) as input, creates monthly
    % subfolders and moves .wav files into subfolders based on date in file name

% DEPENDENCIES:

    % MUCA.time.readDateTime
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Select directory (modify line 21)

% path to input .wav file directory (must end with \)
infilepath = 'D:\GMB_2022_10\AMAR388.1.32000.HTI-99-HF\';


%% Set up

tic

% get list of wav file names
files = dir([infilepath '*.wav']);

% read datetime stamps from file names and format as year-month
filedate = MUCA.time.readDateTime({files.name}, 'yyyy-MM');

% get unique year-month combinations and format as string for folder names
yearmonth = unique(string(filedate));

% create monthly subfolders (mkdir function is not vectorized so have to use a loop here)
for ym = 1:length(yearmonth)
    
    mkdir(fullfile(infilepath, yearmonth(ym)));
    
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