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

% read datetime stamps from file names
filedate = MUCA.time.readDateTime({files.name});

% create date vector from file names
dt_vec = datevec(filedate);

% extract year and month from date vector, get unique combinations
yearmonth = num2cell(unique(dt_vec(:,1:2),'rows'));

% combine year and month for folder names
yearmonth_folders = join(string(yearmonth), '_');

% create monthly subfolders (mkdir function is not vectorized so have to use a loop here)
for ym = 1:length(yearmonth_folders)
    
    mkdir(fullfile(infilepath, yearmonth_folders(ym)));
    
end

%% Loop through files and move to monthly subfolders

for f = 1:length(files)
    
    fullfilepath = fullfile(infilepath, files(f).name);
    
    % get year and month for file f
    f_date = dt_vec(f,1:2);

    % combine year and month for folder name
    f_folder = join(string(num2cell(f_date)), '_');
  
    monthfolder = fullfile(infilepath, f_folder);
    
    movefile(fullfilepath, monthfolder)
    
end
    
toc