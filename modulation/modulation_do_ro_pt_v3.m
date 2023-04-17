%% modulation analysis by significance check
% modulation anlaysis by ANOVA

bin_s = 10;
clear mod_sort
mod_bin = [25 75];
mod_bin_do = [40 60];

pos_neg_bin = [1 2; 3 5];
signf_v = 0.05;


for m = 1:size(Mdata,2)
    
        %% reach modulated
        clear mod_sort
    for s = 1:size(Mdata{m}.ca2data_reaching,2)
        tmp_rej = [];
        tmp_ca2data = Mdata{m}.ca2data_reaching{s};
        rt = Mdata{m}.gpio.touch{s};
        rt(Mdata{m}.ca2data_rej{s}) = [];
    %     tmp_ca2data = ro_rt_fil(tmp_ca2data,ro,rt,0.5);
        Mdata{m}.ca2data_reaching{s} = tmp_ca2data;

        tmp_mod = [];
        tmp_sign_h = [];
        h = [];
     
        [tmp_mod tmp_sign h mean_mat] = mod_kk_anova_v1(tmp_ca2data(:,:,mod_bin(1):mod_bin(2)),bin_s,signf_v);

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

    end
    Mdata{m}.mod_sort = mod_sort;
    figure
    %plot tiling
    clims = [0 1];
    k = 0;
    % for i = 1:size(Mdata{m}.ca2data_reaching,2)
    % gpio_lst{k} = dir_gpio(i).name
    for i = 1:3
        k = k+1;
        subplot(ceil(sqrt(size(Mdata{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata{m}.ca2data_reaching,2)))*2,k)
%         tmp_data = zscore(squeeze(mean(Mdata{m}.ca2data_reaching{i})),[],2);
        tmp_data = normalize(squeeze(mean(Mdata{m}.ca2data_reaching{i})),2,'range');
        tmp_mod_all = [Mdata{m}.mod_sort.unsort_sign{i}];

    %     try
        tmp_idx = mod_tiling_1input(tmp_mod_all,tmp_data);

    %     tmp_plt = [tmp_mod_bi(tmp_idx)'];
        tmp_plt = tmp_mod_all';
        imagesc(t_dpoint,[],tmp_data(tmp_idx,:))
    %     end

        k = k+1;
        subplot(ceil(sqrt(size(Mdata{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata{m}.ca2data_reaching,2)))*2,k)
        imagesc(tmp_plt(tmp_idx,:),clims);
    end
end
m = 1;
s = 1;
%plot trial
% for s = 1:size(ca2data_reaching,2)
    tmp_data = Mdata{m}.ca2data_reaching{s};
    tmp_mod_bi = Mdata{m}.mod_sort.unsort_sign{s};

    figure
    for i = 1:size(tmp_data,2)
        subplot(ceil(sqrt(size(tmp_data,2))),ceil(sqrt(size(tmp_data,2))),i)
        imagesc(t_dpoint,[],squeeze(tmp_data(:,i,:)));
        if tmp_mod_bi(i) == 1
            mod_disp{1} = 'RT m';
        else
            mod_disp{1} = 'RT nm';
        end

        title([mod_disp{1}])
    end

%plot trial
% for s = 1:size(ca2data_reaching,2)
tmp_data = Mdata{m}.ca2data_reaching{s};
tmp_mod_bi = Mdata{m}.mod_sort.unsort_sign{s};

figure
plt_add = 0;
k = 1;
for i = [17 47]
    subplot(1,2,k)
    k = k+1;
    for tr = 2:size(tmp_data,1)
        plt_add = plt_add + max(squeeze(tmp_data(tr-1,i,:)));
        plot(t_dpoint,squeeze(tmp_data(tr,i,:))+plt_add,'k');
        hold on
    end
    if tmp_mod_bi(i) == 1
        mod_disp{1} = 'RT m';
    else
        mod_disp{1} = 'RT nm';
    end

    title([mod_disp{1}])
end
    
    
    
% m = 1;
% s = 1;
% %plot trial
% % for s = 1:size(ca2data_reaching,2)
%     tmp_data = Mdata{m}.ca2data_reaching{s};
%     tmp_mod_bi = Mdata{m}.mod_sort.unsort_sign{s};
%     tmp_Wmod = Mdata{m}.mod_sort.Wsignif{s};
%     figure
%     for i = 1:size(tmp_data,2)
%         subplot(ceil(sqrt(size(tmp_data,2))),ceil(sqrt(size(tmp_data,2))),i)
%         tmp_base_corrected = (squeeze(mean(tmp_data(:,i,:))) - mean(squeeze(mean(tmp_data(:,i,1:10)))))/mean(squeeze(mean(tmp_data(:,i,1:10))));
%         plot(t_dpoint,tmp_base_corrected);
%         hold on
%         yline(std(tmp_base_corrected)*2,'r');
%         yline(-std(tmp_base_corrected)*2,'b');
%         if tmp_mod_bi(i) == 1
%             if tmp_Wmod(i) == 1
%                 title('mod/Wmod');
%             else
%                 title('mod/non-Wmod');
%             end
%         else
%             if tmp_Wmod(i) == 1
%                 title('non-mod/Wmod');
%             else
%                 title('non-mod/non-Wmod');
%             end
%         end
%     end

% m = 1;
% s = 1;

figure
%plot tiling
clims = [0 1];
k = 0;
% for i = 1:size(Mdata{m}.ca2data_reaching,2)
% gpio_lst{k} = dir_gpio(i).name

for i = 1
    k = k+1;
    subplot(1,1,k)
    tmp_data = zscore(squeeze(mean(Mdata{m}.ca2data_reaching{i})),[],2);
    tmp_mod_all = Mdata{m}.mod_sort.unsort_sign{i};
    
    tmp_mod_all(find(tmp_mod_all > 0)) = 1;
%     try
    tmp_idx = mod_tiling_1input(tmp_mod_all,tmp_data);
    tmp_add = 0;
%     tmp_plt = [tmp_mod_bi(tmp_idx)'];
    for c = 1:size(tmp_data,1)
    tmp_add = tmp_add - max(tmp_data(tmp_idx(c),:));
    plot(t_dpoint,tmp_data(tmp_idx(c),:)+tmp_add,'k');
    hold on
    end
%     end

end