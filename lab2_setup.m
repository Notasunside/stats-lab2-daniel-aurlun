function [script_folder, data_folder, output_folder] = lab2_setup()

%requir: statistics and Machine Learning Toolbox.

script_folder = fileparts(mfilename('fullpath'));
data_folder= fullfile(script_folder, 'data');
output_folder = fullfile(script_folder, 'results');
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end
end
