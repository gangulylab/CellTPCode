% post cell sess
clear all
close all

%% load data
foname = 'C:\Users\chopa\Box\Transplant_Data\Caiman\Behavior\Matlab_save\data_save\zenodo\';
finame = 'TP_thy1_Ncomm.mat';   %
load([foname finame])

ts_cal = 0.1;
margin = 0; %time point margin to separate early activated and late activated
s_window = 10;  % second
pre_r = 0.5;
n_dpoint = round(s_window/ts_cal);
pre_win = round(pre_r*s_window/ts_cal);
post_win = n_dpoint-pre_win;

iti_t = [-9 -2];
iti_win = [round(iti_t(1)/ts_cal) round(iti_t(2)/ts_cal)];


t_dpoint = (-1)*pre_win*ts_cal:ts_cal:post_win*ts_cal;

MEC = [0 0 0; 0 0 0.8; 0.8 0 0; 0.4940 0.1840 0.5560; 0.4660 0.6740 0.1880; 0.3010 0.7450 0.9330; 0.6350 0.0780 0.1840];
run('comp_base_task.m')
run([pwd '/modulation/modulation.m'])
