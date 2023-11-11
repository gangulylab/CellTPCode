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

end