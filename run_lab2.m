%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STAT 4714 LAB 2 -- Aurlun Nelson and Daniel Kim
% 
% required library:
% - statistics
% - Machine Learning Toolbox (anova1, ttest2, boxplot)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
%clf;
clc;
close all;

script_folder = fileparts(mfilename('fullpath'));
addpath(script_folder);
run(fullfile(script_folder, 'M2_lab2_summaries.m')); %--pulls a lot from M2 results%
run(fullfile(script_folder, 'M2_lab2_parallel.m')); %--pulls a lot from M2 results%

run(fullfile(script_folder, 'lab2_pair_tests.m')); %--item 3%
run(fullfile(script_folder, 'lab2_clock_tests.m'));%--item 5%
run(fullfile(script_folder, 'lab2_tradeoff.m')); %--item SIX SEVEN%
fprintf('\nCompletare! CSV tables and figures are in results/ folder.\n');
