%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to organize .wav files into semi-monthly subfolders for the purpose of
% creating LTSAs in cases where a full month exceeds the LTSA data limit

    % J. Stanistreet, 20 January 2025 (MATLAB R2024a)

% DESCRIPTION:

    % Takes a deployment folder (directory of .wav files) as input, creates semi-monthly
    % subfolders and moves .wav files into subfolders based on date in file name

% DEPENDENCIES:

    % MUCA.time.readDateTime
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Select directory (modify line 21)

% path to input .wav file directory (must end with \)
infilepath = 'D:\CSE_2023_08\AMAR668.1.32000\';


%% Set up

tic

% get list of wav file names
files = dir([infilepath '*.wav']);

% read datetime stamps from file names and format as year-month
filemonth = MUCA.time.readDateTime({files.name}, 'yyyy-MM');

% get unique year-month combinations and format as string for folder names
yearmonth = unique(string(filemonth));

% create monthly subfolders (mkdir function is not vectorized so have to use a loop here)
for ym = 1:length(yearmonth)
    
    folder1 = join([yearmonth(ym), 'A'],'');
    folder2 = join([yearmonth(ym), 'B'],'');

    mkdir(fullfile(infilepath, folder1));
    mkdir(fullfile(infilepath, folder2));
    
end


%% Loop through files and move to monthly subfolders

for f = 1:length(files)
    
    % get full path to file
    fullfilepath = fullfile(infilepath, files(f).name);

    % get year and month of file (as string)
    f_month = string(filemonth(f)); 

    % get file date formatted as day of month
    f_date = MUCA.time.readDateTime(fullfilepath, 'dd');

    % convert day of month to number
    f_date_num = str2double(string(f_date));

    if f_date_num <= 15
        f_folder = join([f_month, 'A'], '');
    elseif f_date_num > 15
        f_folder = join([f_month, 'B'], '');
    end

    % get full path to correct month folder
    monthfolderpath = fullfile(infilepath, f_folder);
    
    % move file to month folder
    movefile(fullfilepath, monthfolderpath)
    
end
    

%% Delete any empty (unused) subfolders

% contents of parent folder
allcontents = dir(infilepath);

% list subfolders
allsubfolders = {allcontents([allcontents.isdir]).name};

% remove '.' and '..' entries from list
allsubfolders(ismember(allsubfolders,{'.','..'})) = [];

% get full paths to subfolders
subfolderpaths = fullfile(infilepath, allsubfolders);

% remove subfolders
for sf = 1:length(subfolderpaths)
    
    % delete folder if empty
    if length(dir(subfolderpaths{sf})) == 2
        
        rmdir(subfolderpaths{sf})
        
    end
    
end

toc