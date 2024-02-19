%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to trim .wav file duration to integer second

    % J. Stanistreet, 15 February 2024 (MATLAB R2020a)

% DESCRIPTION:

    % Processes a directory of .wav files to create a new set of files with
    % fractional second trimmed off the end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Choose input and output folders: modify lines 17 & 20

% path to input .wav file directory (must end with \)
infilepath = 'D:\Bb4_LTSA\';

% path to output directory (must end with \)
outfilepath = 'D:\Bb4_LTSA_NEW\';

%% Loop through files

files = dir([infilepath '*.wav']);

for rr = 1:length(files)
    
    % get file info
    info = audioinfo([infilepath files(rr).name]);
    
    % determine file length needed (to nearest integer second)
    out_file_duration = floor(info.Duration); 
    out_file_samples = out_file_duration*info.SampleRate;
    samples = [1,out_file_samples];
    
    % read in segment of interest
    seg2keep = audioread([infilepath files(rr).name], samples);
    
    % write new file
    outputfilename = [files(rr).name];
    audiowrite([outfilepath outputfilename], seg2keep, info.SampleRate, 'BitsPerSample', info.BitsPerSample);
    
    clear info out_file_duration out_file_samples samples seg2keep outputfilename
    
end
    