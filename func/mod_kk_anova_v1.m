function [out signif h mean_mat] = mod_kk_anova_v1(x_in,bin_s,signf_v)

    for c = 1:size(x_in,2)
        ca2data = squeeze(x_in(:,c,:));
%         ca2data = zscore(ca2data,[],2);
        %bin average
        tmp_re_mean = [];
        
        for i = 1:size(ca2data,1)
            tmp_ca2data = ca2data(i,1:floor(size(ca2data,2)/bin_s)*bin_s);
            tmp_re_ca2data = reshape(tmp_ca2data,bin_s,floor(size(ca2data,2)/bin_s));
            tmp_re_mean(i,:) = mean(tmp_re_ca2data,'omitnan');
        end
        tmp_ttest_h = NaN(size(tmp_re_mean,2),size(tmp_re_mean,2));
        tmp_ttest_p = NaN(size(tmp_re_mean,2),size(tmp_re_mean,2));
        try
            [tmp_p,tmp_tbl,tmp_stats] = anova1(tmp_re_mean,[],'off');
            tmp_c = multcompare(tmp_stats,'Display','off','CType','bonferroni');
            for i = 1:size(tmp_c,1)
                tmp_ttest_p(tmp_c(i,1),tmp_c(i,2)) = tmp_c(i,6);
                tmp_ttest_h(tmp_c(i,1),tmp_c(i,2)) = length(find(tmp_c(i,6) < signf_v));
            end
        end
        h{c} = tmp_ttest_h;
        out{c} = tmp_ttest_p;
        signif(c) = length(find(tmp_ttest_h == 1));
        mean_mat(c,:,:) = tmp_re_mean;
    end
    signif(find(signif >0)) = 1;
    
end

