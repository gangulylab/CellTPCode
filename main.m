% Main entry point: load session data, build task-aligned calcium matrices,
% then run the modulated-cell detection analysis.
clear all
close all

%% Load data
% Point data_root at the folder where you downloaded the dataset. Paths are
% built with fullfile, so this works on Windows, macOS, and Linux.
data_root = 'Transplant_Data';   % <-- set this to your data folder
data_file = fullfile(data_root, 'Caiman', 'Behavior', 'Matlab_save', 'data_save', 'zenodo', 'TP_thy1_Ncomm.mat');
load(data_file)

%% Analysis parameters
ts_cal    = 0.1;              % calcium sampling period (s)
margin    = 0;               % time-point margin separating early- vs late-activated cells
s_window  = 10;              % analysis window length (s)
pre_r     = 0.5;             % fraction of the window placed before the event
n_dpoint  = round(s_window/ts_cal);        % samples per window
pre_win   = round(pre_r*s_window/ts_cal);  % samples before the event
post_win  = n_dpoint-pre_win;              % samples after the event

% Inter-trial-interval window (s -> samples)
iti_t   = [-9 -2];
iti_win = [round(iti_t(1)/ts_cal) round(iti_t(2)/ts_cal)];

% Time axis (s) for each aligned window, event at t = 0
t_dpoint = (-1)*pre_win*ts_cal:ts_cal:post_win*ts_cal;

% Per-group plotting colors
MEC = [0 0 0; 0 0 0.8; 0.8 0 0; 0.4940 0.1840 0.5560; 0.4660 0.6740 0.1880; 0.3010 0.7450 0.9330; 0.6350 0.0780 0.1840];

%% Run pipeline
run('comp_base_task.m')
run([pwd '/modulation/modulation.m'])
