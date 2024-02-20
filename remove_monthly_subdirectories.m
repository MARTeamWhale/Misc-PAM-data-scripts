%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to move .wav files and .ltsa files from subfolders to parent folder & delete
% empty subfolders

    % J. Stanistreet, 19 February 2024 (MATLAB R2020a)

% DESCRIPTION:

    % Takes a parent-level directory as input, finds .wav files and .ltsa files in
    % subdirectories, moves all to parent folder, checks if subfolders are
    % empty and deletes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Select directory (modify line 18)

% path to parent folder (must end with \)
parentdir = 'D:\GMB_2022_10\AMAR388.1.32000.HTI-99-HF\';


%% Set up

tic

% recursively find all wav files and ltsa files
wavfiles = dir(fullfile(parentdir, '**\*.wav'));
%ltsafiles = dir(fullfile(parentdir, '**\*.ltsa'));

%% Loop through wav files and move to parent folder

for wf = 1:length(wavfiles)
    
    fullfilepath = fullfile(wavfiles(wf).folder, wavfiles(wf).name);
    
    movefile(fullfilepath, parentdir)
    
end
    
%% Loop through ltsa files and move to new LTSA folder

% for lf = 1:length(ltsafiles)
%     
%     fullfilepath = fullfile(ltsafiles(wf).folder, ltsafiles(wf).name);
%     
%     movefile(fullfilepath, parentdir)
%     
% end

%% Delete empty subfolders

% contents of parent folder
allcontents = dir(parentdir);

% list subfolders
allsubfolders = {allcontents([allcontents.isdir]).name};

% remove '.' and '..' entries from list
allsubfolders(ismember(allsubfolders,{'.','..'})) = [];

% get full paths to subfolders
subfolderpaths = fullfile(parentdir, allsubfolders);

% remove subfolders
for sf = 1:length(subfolderpaths)
    
    % check if folder is empty, display message if not
    if length(dir(subfolderpaths{sf})) > 2
        
        msg = ['Folder not empty: ', subfolderpaths{sf}];
        disp(msg)
    
    % if empty, delete folder
    elseif length(dir(subfolderpaths{sf})) == 2
        
        rmdir(subfolderpaths{sf})
        
    end
    
    clear msg
    
end

toc