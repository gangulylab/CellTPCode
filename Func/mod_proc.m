function out = mod_proc(tmp_ca2data,mod_bin)
    bin_s = 5;
%     mod_bin = [25 75];
    pos_neg_bin = [1 2; 3 4];
    signf_v = 0.05;
    tmp_mod = [];
    tmp_sign_h = [];
    h = [];

    [tmp_mod tmp_sign h mean_mat] = mod_kk_anova_v1(tmp_ca2data(:,:,mod_bin(1):mod_bin(2)),bin_s,signf_v);

    out.ca2data_mod = tmp_mod;
    out.unsort_sign = tmp_sign;
    out.h = h;
    out.mean_mat = mean_mat;
    tmp_mean_mat = squeeze(mean(mean_mat,2));
    %pos and neg mod labeling
%     tmp_base = mean(tmp_mean_mat(:,pos_neg_bin(1,1):pos_neg_bin(1,2)),2);
%     tmp_target = mean(tmp_mean_mat(:,pos_neg_bin(2,1):pos_neg_bin(2,2)),2);
%     tmp_pos_neg = tmp_target-tmp_base;
%     tmp_pos_neg(find(tmp_pos_neg > 0)) = 1;
%     tmp_pos_neg(find(tmp_pos_neg <0)) = 0;
%     tmp_pone_out = tmp_sign+(tmp_sign & tmp_pos_neg');
%     out.unsort_sign_pone = tmp_pone_out;
%     out.sign = tmp_pos_neg;
end