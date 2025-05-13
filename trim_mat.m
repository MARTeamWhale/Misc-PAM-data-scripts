% trim .mat files to shorter duration from directory of MAT files

clear
close all

% input file directory
matDir = 'F:\BEAKED_WHALE_ANALYSIS\MGL_2019_10_tests\mat';

% output file directory
outDir = 'F:\BEAKED_WHALE_ANALYSIS\MGL_2019_10_tests\mat_clipped';
    if ~exist(outDir, 'dir')
       mkdir(outDir)
    end

if strcmp(matDir,outDir)
    error("Input directory must be different from output directory")
end

% specify clip duration 
clip_dur = 65;

%%%%%%%%%%%%%%%%%%%%%

% list files in folder 
d = dir(fullfile(matDir,'*1.mat'));
mat_names = char(d.name); % file names
cd(matDir)

for a = 1:length(mat_names)
    matname = mat_names(a,:);
    load(mat_names(a,:));
    rawDur = clip_dur;
    rawStart = rawStart(1,:);
    pos = pos(pos(:,2) < rawDur);
    clip_index = [1:length(pos)]';
    bw10db = bw10db(clip_index,:);
    bw3db = bw3db(clip_index,:);
    dur = dur(clip_index,:);
    F0 = F0(clip_index,:);
    ici = ici(1:length(clip_index)-1,:);
    nSamples = nSamples(clip_index,:);
    peakFr = peakFr(clip_index,:);
    ppSignal = ppSignal(clip_index,:);
    rmsNoise = rmsNoise(clip_index,:);
    rmsSignal = rmsSignal(clip_index,:);
    slope = slope(clip_index,:);
    snr = snr(clip_index,:);
    specClick = specClick(clip_index,:);
    specNoise = specNoise(clip_index,:);
    yFilt = yFilt(clip_index,:);
    yNFilt = yNFilt(clip_index,:);
     
    save(fullfile(outDir,matname),"bw10db", "bw3db", "dur", "F0", "fs", "ici", "nSamples", "offset", "peakFr", "pos", "ppSignal", "rawDur", "rawStart", "rmsNoise", "rmsSignal", "slope", "snr", "specClick", "specNoise", "yFilt", "yNFilt")

    

end