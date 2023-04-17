%% modulation analysis by significance check
% modulation anlaysis by ANOVA
signf = 0.08;
bin_s = 10;
clear mod_sort
% mod_bin = [1 75];
% wmod_bin = [1 75];
mod_bin = [25 75];
mod_bin_do = [40 60];
% pos_neg_bin = [1 3; 5 6];
pos_neg_bin = [1 2; 3 5];
signf_v = 0.05;
signf_w = 0.5;
for m = 1:size(Mdata_thy1,2)
    
    %% reach modulated
    clear mod_sort
for s = 1:size(Mdata_thy1{m}.ca2data_reaching,2)
    tmp_rej = [];
    tmp_ca2data = Mdata_thy1{m}.ca2data_reaching{s};
    
    tmp_mod = [];
    tmp_sign_h = [];
    h = [];
    try
        [tmp_mod tmp_sign h mean_mat] = mod_kk_anova_v1(tmp_ca2data(:,:,mod_bin(1):mod_bin(2)),bin_s,signf_v);
    end
    try
        ca2data_mod{s,:} = tmp_mod;
        mod_sort.unsort_sign{s} = tmp_sign;
        mod_sort.h{s,:} = h;
        mod_sort.mean_mat{s} = mean_mat;
        tmp_mean_mat = squeeze(mean(mean_mat,2));
        %pos and neg mod labeling
        tmp_base = mean(tmp_mean_mat(:,pos_neg_bin(1,1):pos_neg_bin(1,2)),2);
        tmp_target = mean(tmp_mean_mat(:,pos_neg_bin(2,1):pos_neg_bin(2,2)),2);
        tmp_pos_neg = tmp_target-tmp_base;
        tmp_pos_neg(find(tmp_pos_neg > 0)) = 1;
        tmp_pos_neg(find(tmp_pos_neg <0)) = 0;
        tmp_pone_out = tmp_sign+(tmp_sign & tmp_pos_neg');
        mod_sort.unsort_sign_pone{s} = tmp_pone_out;
    catch
        display(['error' num2str(m) ' ' num2str(s) ' ' num2str(j)])
    end
end
Mdata_thy1{m}.mod_sort = mod_sort;

figure
%plot tiling
clims = [0 1];
k = 0;
% for i = 1:size(Mdata{m}.ca2data_reaching,2)
% gpio_lst{k} = dir_gpio(i).name
for i = 1:size(Mdata_thy1{m}.pica_b.traces,2)
    k = k+1;
    subplot(ceil(sqrt(size(Mdata{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata{m}.ca2data_reaching,2)))*2,k)
    tmp_data = zscore(squeeze(mean(Mdata_thy1{m}.ca2data_reaching{i})),[],2);
    tmp_mod_bi = [Mdata_thy1{m}.mod_sort.unsort_sign{i}];
    tmp_mod_all = tmp_mod_bi;
    tmp_mod_all(find(tmp_mod_all > 0)) = 1;
%     try
    tmp_idx = mod_tiling_1input(tmp_mod_all,tmp_data);
    
%     tmp_plt = [tmp_mod_bi(tmp_idx)'];
    tmp_plt = tmp_mod_all';
    imagesc(t_dpoint,[],tmp_data(tmp_idx,:))
%     end
%     title(Mdata{m}.lst{i}(1:10))
    k = k+1;
    subplot(ceil(sqrt(size(Mdata{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata{m}.ca2data_reaching,2)))*2,k)
    imagesc(tmp_plt(tmp_idx,:),clims);
end

end



