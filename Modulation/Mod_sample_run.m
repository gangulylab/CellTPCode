%% modulation analysis by ANOVA significance check
%
td = 0.1;
t_dpoint = -5:td:5;  % sample data time point -5s to 5s
mod_bin = [25 75]; % note data point 51 is 0s (i.e., pellet drop) to take -2.5s to +2.5s in 10Hz data [25 75]


load('ca_reaching_sample.mat');
tmp_mod_sort_pt = mod_proc(sample_reaching,mod_bin);
N_mod = length(find(tmp_mod_sort_pt.unsort_sign == 1));
R_mod = N_mod/size(tmp_mod_sort_pt.unsort_sign,2);
display(['Modulated cell number = ' num2str(N_mod)])
display(['Mod cell in % = ' num2str(R_mod)])

%plot tiling
figure
clims = [0 1]; % color range limit for mod labeling
tmp_data = normalize(squeeze(mean(sample_reaching)),2,'range'); % zscore
tmp_idx = mod_tiling_1input(tmp_mod_sort_pt.unsort_sign,tmp_data); % sorting mod tiling 
subplot(1,2,1)
imagesc(t_dpoint,[],tmp_data(tmp_idx,:)) % plot tiling
subplot(1,2,2)
imagesc(tmp_mod_sort_pt.unsort_sign(tmp_idx)',clims); % plot mod cells mod in yellow


