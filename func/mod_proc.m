function out = mod_proc(tmp_ca2data,mod_bin)
% Test each cell for task modulation over the window mod_bin via ANOVA.
    bin_s   = 5;      % samples per averaging bin
    signf_v = 0.05;   % significance threshold

    [tmp_mod, tmp_sign, h, mean_mat] = mod_kk_anova_v1(tmp_ca2data(:,:,mod_bin(1):mod_bin(2)),bin_s,signf_v);

    out.ca2data_mod = tmp_mod;
    out.unsort_sign = tmp_sign;
    out.h           = h;
    out.mean_mat    = mean_mat;
end