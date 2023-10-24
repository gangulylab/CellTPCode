clear FA*
n_fa = 2;
for m = 1:size(Mdata,2)
    tmp_Mdata = Mdata{m};
    
    for s = 1:size(tmp_Mdata.ca2data_reaching,2)
        tmp_mod_bi = tmp_Mdata.mod_pt_do{s};
        tmp_idx = find(tmp_mod_bi == 1);
        tmp_fa_mean = squeeze(mean(tmp_Mdata.ca2data_reaching{s}));
        tmp_psi = 0;
        try [FA.lambda{m,s},tmp_psi,tmp_T,tmp_stats,FA.F{m,s}] = factoran(transpose(tmp_fa_mean),n_fa);
            tmp_sot(m,s) = mean(1-tmp_psi);
        catch
            dim_in = 80;
            [FA.lambda{m,s},tmp_psi,tmp_T,tmp_stats,FA.F{m,s}] = rnd_FA_mean(transpose(tmp_fa_mean),n_fa,dim_in);
            tmp_sot(m,s) = mean(1-tmp_psi);
        end
        
    end
end
figure
out = plt_ebar(tmp_sot);
set(gcf,'color','w');
title('transplanted sot')

for m = 1:size(Mdata_thy1,2)
    tmp_Mdata = Mdata_thy1{m};
    
    for s = 1:size(tmp_Mdata.ca2data_reaching,2)
        tmp_mod_bi = tmp_Mdata.mod_pt_do{s};
        tmp_idx = find(tmp_mod_bi == 1);
        tmp_fa_mean = squeeze(mean(tmp_Mdata.ca2data_reaching{s}));
        tmp_psi = 0;
        try [FA_thy1.lambda{m,s},tmp_psi,tmp_T,tmp_stats,FA_thy1.F{m,s}] = factoran(transpose(tmp_fa_mean),n_fa);
            tmp_sot_thy1(m,s) = mean(1-tmp_psi);
        catch
            dim_in = 80;
            [FA_thy1.lambda{m,s},tmp_psi,tmp_T,tmp_stats,FA_thy1.F{m,s}] = rnd_FA_mean(transpose(tmp_fa_mean),n_fa,dim_in);
            tmp_sot_thy1(m,s) = mean(1-tmp_psi);
        end
        
    end
end


k = 0;
figure
for m = 1:size(FA_thy1.F,1)
    for s = 1:size(FA_thy1.F,2)
        k = k+1;
        subplot(size(FA_thy1.F,1),size(FA_thy1.F,2),k)
        tmp_lambda = FA_thy1.lambda{m,s};
        tmp_lambda_p = sqrt(tmp_lambda'*tmp_lambda/size(tmp_lambda,1));
        tmp_rms_lambda = diag(tmp_lambda_p)';
        FA_thy1.rms_L{m,s} = tmp_rms_lambda;
        tmp_plt = FA_thy1.F{m,s};
        plot(t_dpoint,tmp_plt)
        ylim([-1 2])
    end
end
set(gcf,'color','w');
figure
out = plt_ebar(tmp_sot_thy1);
set(gcf,'color','w');
title('Healthy sot')

%since the positive definite matrix issue, random selelction of cell
%performed, the result may changed slightly each performance

k = 0;
figure
for m = 1:size(FA_thy1.F,1)
    for s = 1:size(FA_thy1.F,2)
        k = k+1;
        subplot(size(FA_thy1.F,1),size(FA_thy1.F,2),k)

            tmp_plt = FA_thy1.F{m,s};
            plot(t_dpoint,tmp_plt)
    end
end
set(gcf,'color','w');


tmp_plt_sel_TP = 6;
tmp_plt_sel_thy1 = 3;
% rotate control
tmp_rtate_TP = 0;
tmp_rtate_thy1 = 0;

figure

tmp_MFA_TP_score = FA.F{tmp_plt_sel_TP};
tmp_MFA_thy1_score = FA_thy1.F{tmp_plt_sel_thy1};

if tmp_rtate_TP == 1
    tmp_idx = sort(1:size(tmp_MFA_TP_score,2),'descend');
    tmp_MFA_TP_score = tmp_MFA_TP_score(:,tmp_idx);
end
if tmp_rtate_thy1 == 1
    tmp_idx = sort(1:size(tmp_MFA_thy1_score,2),'descend');
    tmp_MFA_thy1_score = tmp_MFA_thy1_score(:,tmp_idx);
end

for s = 1:size(FA.F,2)
    tmp_score = FA.F{tmp_plt_sel_TP,s};
    out = plt_traj(tmp_score,50);
    hold on

end

for s = 1
    tmp_score = tmp_MFA_thy1_score;
    out = plt_traj(tmp_score,50);
    hold on

end

%% 

