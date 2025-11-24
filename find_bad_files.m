
clear
close all

import multimedia.internal.audio.file.PluginManager;

% input file directory
Dir = 'C:\Users\adamsmi\Desktop\TEST';

% list files in folder 
d = dir(fullfile(Dir,'*.wav'));
files = char(d.name); % file names
cd(Dir)

bad = zeros(length(d),1);

for a = 1:height(files)
    filename = files(a,:);
    try
        readPlugin = PluginManager.getInstance.getPluginForRead(filename);
    catch exception
        % The exception has been fully formed. Only the prefix has to be
        % replaced.
        exception = PluginManager.replacePluginExceptionPrefix(exception, 'MATLAB:audiovideo:audioinfo');
        bad(a) = 1;
     
    end
end

bad_files = d(bad == 1,:);