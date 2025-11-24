%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to split AMAR .wav files into shorter segments

    % J. Stanistreet, last modified 24 November 2025 (MATLAB R2024a)

% DESCRIPTION:

    % Processes a directory of .wav files to create a new set of files
    % split into shorter length, as specified by user.
 
% DEPENDENCIES:

    % MUCA.time.readDateTime
    
% NOTES:

    % Any .wav file in the input dataset with a length shorter than the
    % specified segment length will be written to the output directory
    % without modification.
    
    % Any file segment with a length of <1 s will NOT be written to
    % a new .wav file, to avoid creating tiny files in cases when the
    % original file duration is a fraction of a second longer than
    % expected.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
close all

%% Modify as needed:

% path to input .wav file directory
infilepath = 'C:\Users\STANISTREETJ\Desktop\TEST\original';

% path to output directory
outfilepath = 'C:\Users\STANISTREETJ\Desktop\TEST\output';

% specify new file duration in minutes
seg_length_min = 10;


%% Set up

tic;

files = dir(fullfile(infilepath, '**\*.wav'));

%% Loop within folder containing wav files
for f = 1:length(files)
    
    info = audioinfo(fullfile(infilepath, files(f).name));
    fs = info.SampleRate; % samples per second
    file_length_samples = info.TotalSamples;
    start_time = MUCA.time.readDateTime(files(f).name);
    file_name = files(f).name;
    
    % define segment length
    seg_samples = seg_length_min*60*fs; % segment length in min * 60 seconds in a min * number of sample per sec
    numloops = ceil(file_length_samples/seg_samples); % round up, last output file may be < segment length
    
    %% Loop over number of segments within a file
    for s = 1:numloops
        
        % Define the sample numbers for start and stop of each segment
        if s==1 && s~=numloops
            samples = [1, seg_samples];
        elseif s==numloops
            samples = [(s-1)*seg_samples+1, file_length_samples];
        else
            samples = [(s-1)*seg_samples+1, s*seg_samples];
        end
        seg2keep = audioread(fullfile(infilepath, files(f).name), samples);
        
        %% name and write the output file
        
        if length(seg2keep)/fs > 1 % to avoid writing files with length of less than 1s
            thisstarttime = start_time+seconds((s-1)*seg_samples/fs);
            originaltimestamp = string(datetime(start_time, "Format", 'yyyyMMdd''T''HHmmss''Z'));
            newtimestamp = string(datetime(thisstarttime, "Format", 'yyyyMMdd''T''HHmmss''Z'));
            newfilename = replace(file_name, originaltimestamp, newtimestamp);
            audiowrite(fullfile(outfilepath, newfilename), seg2keep, fs);            
        else
            disp('') %do nothing
        end
        
        clear samples seg2keep thisstarttime outputfilename
    end %s
    
    clear info fs file_length_samples start_time seg_samples numloops
end %f

toc