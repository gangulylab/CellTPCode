Mdata_comb = comb4depth_v2(Mdata,3);
Mdata_thy1_comb = comb4depth_v2(Mdata_thy1,1);
bin_range = 0:200:1000;
% binning in 100um
for s = 1:size(Mdata_comb,2)
    tmp_depth = Mdata_comb{s}.depth-100; % 100um subtraction for depth correction
    tmp_mod = Mdata_comb{s}.mod;
    tmp_depth_mod = tmp_depth(find(tmp_mod == 1));
    tmp_depth_Nmod = tmp_depth(find(tmp_mod == 0));
    Mdata_comb{s}.bin_cnt_mod = d2bin(tmp_depth_mod, bin_range);
    Mdata_comb{s}.bin_cnt_Nmod = d2bin(tmp_depth_Nmod, bin_range);
end

stage = {'Early', 'Mid', 'Late'};
figure
for s = 1:3
    subplot(1,3,s)
    tmp_plt_tp = [Mdata_comb{s}.bin_cnt_mod; ... 
        Mdata_comb{s}.bin_cnt_Nmod];
    tmp_plt_tp = tmp_plt_tp/sum(tmp_plt_tp,'all')*100;


    bar(tmp_plt_tp','stacked')

    tmp_plt_tp./sum(tmp_plt_tp);
    ylabel('')
    title(stage{s})
    xlim([0 5])
    
end

%% thy1
s = 1;
tmp_depth = Mdata_thy1_comb{s}.depth;
tmp_mod = Mdata_thy1_comb{s}.mod;
tmp_depth_mod = tmp_depth(find(tmp_mod == 1));
tmp_depth_Nmod = tmp_depth(find(tmp_mod == 0));
Mdata_thy1_comb{s}.bin_cnt_mod = d2bin(tmp_depth_mod, bin_range);
Mdata_thy1_comb{s}.bin_cnt_Nmod = d2bin(tmp_depth_Nmod, bin_range);

tmp_plt_tp = [Mdata_thy1_comb{s}.bin_cnt_mod; ... 
    Mdata_thy1_comb{s}.bin_cnt_Nmod];
tmp_plt_tp = tmp_plt_tp/sum(tmp_plt_tp,'all')*100;

figure
bar(tmp_plt_tp','stacked')

tmp_plt_tp./sum(tmp_plt_tp);
ylabel('')
title('healty')
xlim([0 5])

