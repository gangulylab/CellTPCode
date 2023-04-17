%% modulation analysis by significance check
% modulation anlaysis by ANOVA
mod_bin = [25 75];
mod_bin_do = [45 55];
for m = 1:size(Mdata,2)
    
        %% reach modulated
        clear mod_sort
    for s = 1:size(Mdata{m}.ca2data_reaching,2)
        
        tmp_mod_sort_pt = mod_proc(Mdata{m}.ca2data_reaching{s},mod_bin);
        Mdata{m}.mod_sort_pt.ca2data_mod{s,:} = tmp_mod_sort_pt.ca2data_mod;
        Mdata{m}.mod_sort_pt.unsort_sign{s} = tmp_mod_sort_pt.unsort_sign;
        Mdata{m}.mod_sort_pt.h{s,:} = tmp_mod_sort_pt.h;
        Mdata{m}.mod_sort_pt.mean_mat{s} = tmp_mod_sort_pt.mean_mat;
%         Mdata{m}.mod_sort_pt.unsort_sign_pone{s} = tmp_mod_sort_pt.unsort_sign_pone;
        
        tmp_mod_sort_do = mod_proc(Mdata{m}.ca2data_do{s},mod_bin_do);
        Mdata{m}.mod_sort_do.ca2data_mod{s,:} = tmp_mod_sort_do.ca2data_mod;
        Mdata{m}.mod_sort_do.unsort_sign{s} = tmp_mod_sort_do.unsort_sign;
        Mdata{m}.mod_sort_do.h{s,:} = tmp_mod_sort_do.h;
        Mdata{m}.mod_sort_do.mean_mat{s} = tmp_mod_sort_do.mean_mat;
%         Mdata{m}.mod_sort_do.unsort_sign_pone{s} = tmp_mod_sort_do.unsort_sign_pone;
        
        tmp_mod_bi = [tmp_mod_sort_do.unsort_sign; tmp_mod_sort_pt.unsort_sign];
        tmp_mod_all = sum(tmp_mod_bi);
        tmp_mod_doonly = tmp_mod_sort_do.unsort_sign - tmp_mod_sort_pt.unsort_sign;
        tmp_mod_doonly(find(tmp_mod_doonly <= 0)) = 0;
        tmp_mod_all(find(tmp_mod_all > 0)) = 1;
        Mdata{m}.mod_pt_do{s} = tmp_mod_all;
    end
    
    
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
        tmp_mod_all = Mdata{m}.mod_pt_do{i};

    %     try
        tmp_idx = mod_tiling_1input(tmp_mod_all,tmp_data);

    %     tmp_plt = [tmp_mod_bi(tmp_idx)'];
        tmp_plt = tmp_mod_all';
        imagesc(t_dpoint,[],tmp_data(tmp_idx,:))
        title([num2str(m) 'do-pt'])
    %     end

        k = k+1;
        subplot(ceil(sqrt(size(Mdata{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata{m}.ca2data_reaching,2)))*2,k)
        imagesc(tmp_plt(tmp_idx,:),clims);
    end
    
    figure
    %plot tiling for do
    clims = [0 1];
    k = 0;
    % for i = 1:size(Mdata{m}.ca2data_reaching,2)
    % gpio_lst{k} = dir_gpio(i).name
    for i = 1:3
        k = k+1;
        subplot(ceil(sqrt(size(Mdata{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata{m}.ca2data_reaching,2)))*2,k)
%         tmp_data = zscore(squeeze(mean(Mdata{m}.ca2data_reaching{i})),[],2);
        tmp_data = normalize(squeeze(mean(Mdata{m}.ca2data_do{i})),2,'range');
        tmp_mod_all = Mdata{m}.mod_sort_do.unsort_sign{i};

    %     try
        tmp_idx = mod_tiling_1input(tmp_mod_all,tmp_data);

    %     tmp_plt = [tmp_mod_bi(tmp_idx)'];
        tmp_plt = tmp_mod_all';
        imagesc(t_dpoint,[],tmp_data(tmp_idx,:))
        title([num2str(m) 'do'])
    %     end

        k = k+1;
        subplot(ceil(sqrt(size(Mdata{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata{m}.ca2data_reaching,2)))*2,k)
        imagesc(tmp_plt(tmp_idx,:),clims);
    end
    
    
    figure
    %plot tiling for do
    clims = [0 1];
    k = 0;
    % for i = 1:size(Mdata{m}.ca2data_reaching,2)
    % gpio_lst{k} = dir_gpio(i).name
    for i = 1:3
        k = k+1;
        subplot(ceil(sqrt(size(Mdata{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata{m}.ca2data_reaching,2)))*2,k)
%         tmp_data = zscore(squeeze(mean(Mdata{m}.ca2data_reaching{i})),[],2);
        tmp_data = normalize(squeeze(mean(Mdata{m}.ca2data_reaching{i})),2,'range');
        tmp_mod_all = Mdata{m}.mod_sort_pt.unsort_sign{i};

    %     try
        tmp_idx = mod_tiling_1input(tmp_mod_all,tmp_data);

    %     tmp_plt = [tmp_mod_bi(tmp_idx)'];
        tmp_plt = tmp_mod_all';
        imagesc(t_dpoint,[],tmp_data(tmp_idx,:))
        title([num2str(m) 'pt'])
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
    tmp_mod_bi = Mdata{m}.mod_pt_do{s};

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
tmp_mod_bi = Mdata{m}.mod_pt_do{s};

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
    tmp_mod_all = Mdata{m}.mod_pt_do{i};
    
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

for m = 1:size(Mdata_thy1,2)
    
        %% reach modulated
        clear tmp_mod_*
    for s = 1:size(Mdata_thy1{m}.ca2data_reaching,2)
        
        tmp_mod_sort_pt = mod_proc(Mdata_thy1{m}.ca2data_reaching{s},mod_bin);
        Mdata_thy1{m}.mod_sort_pt.ca2data_mod{s,:} = tmp_mod_sort_pt.ca2data_mod;
        Mdata_thy1{m}.mod_sort_pt.unsort_sign{s} = tmp_mod_sort_pt.unsort_sign;
        Mdata_thy1{m}.mod_sort_pt.h{s,:} = tmp_mod_sort_pt.h;
        Mdata_thy1{m}.mod_sort_pt.mean_mat{s} = tmp_mod_sort_pt.mean_mat;
%         Mdata_thy1{m}.mod_sort_pt.unsort_sign_pone{s} = tmp_mod_sort_pt.unsort_sign_pone;
        
        tmp_mod_sort_do = mod_proc(Mdata_thy1{m}.ca2data_do{s},mod_bin_do);
        Mdata_thy1{m}.mod_sort_do.ca2data_mod{s,:} = tmp_mod_sort_do.ca2data_mod;
        Mdata_thy1{m}.mod_sort_do.unsort_sign{s} = tmp_mod_sort_do.unsort_sign;
        Mdata_thy1{m}.mod_sort_do.h{s,:} = tmp_mod_sort_do.h;
        Mdata_thy1{m}.mod_sort_do.mean_mat{s} = tmp_mod_sort_do.mean_mat;
%         Mdata_thy1{m}.mod_sort_do.unsort_sign_pone{s} = tmp_mod_sort_do.unsort_sign_pone;
        
        tmp_mod_bi = [tmp_mod_sort_do.unsort_sign; tmp_mod_sort_pt.unsort_sign];
        tmp_mod_all = sum(tmp_mod_bi);
        tmp_mod_doonly = tmp_mod_sort_do.unsort_sign - tmp_mod_sort_pt.unsort_sign;
        tmp_mod_doonly(find(tmp_mod_doonly <= 0)) = 0;
        tmp_mod_all(find(tmp_mod_all > 0)) = 1;
        Mdata_thy1{m}.mod_pt_do{s} = tmp_mod_all;
    end
    
    
    figure
    %plot tiling
    clims = [0 1];
    k = 0;
    % for i = 1:size(Mdata{m}.ca2data_reaching,2)
    % gpio_lst{k} = dir_gpio(i).name
    for i = 1:size(Mdata_thy1{m}.ca2data_reaching,2)
        k = k+1;
        subplot(ceil(sqrt(size(Mdata_thy1{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata_thy1{m}.ca2data_reaching,2)))*2,k)
%         tmp_data = zscore(squeeze(mean(Mdata_thy1{m}.ca2data_reaching{i})),[],2);
        tmp_data = normalize(squeeze(mean(Mdata_thy1{m}.ca2data_reaching{i})),2,'range');
        tmp_mod_all = Mdata_thy1{m}.mod_pt_do{i};

    %     try
        tmp_idx = mod_tiling_1input(tmp_mod_all,tmp_data);

    %     tmp_plt = [tmp_mod_bi(tmp_idx)'];
        tmp_plt = tmp_mod_all';
        imagesc(t_dpoint,[],tmp_data(tmp_idx,:))
    %     end

        k = k+1;
        subplot(ceil(sqrt(size(Mdata_thy1{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata_thy1{m}.ca2data_reaching,2)))*2,k)
        imagesc(tmp_plt(tmp_idx,:),clims);
    end
end
tmp_slt_TP = plt_cell_loc(Mdata,5);
tmp_slt_thy1 = plt_cell_loc(Mdata_thy1,3);
tmp_cnt_mod = [];
for m = 1:size(Mdata,2)
    tmp_mod = Mdata{m}.mod_pt_do;
    for s = 1:size(tmp_mod,2)
        tmp_cnt_mod(m,s) = length(find(tmp_mod{s} == 1))/length(tmp_mod{s});
    end
end
tmp_cnt_mod_thy1 = [];
for m = 1:size(Mdata_thy1,2)
    tmp_mod = Mdata_thy1{m}.mod_pt_do;
    for s = 1:size(tmp_mod,2)
        tmp_cnt_mod_thy1(m,s) = length(find(tmp_mod{s} == 1))/length(tmp_mod{s});
    end
end

tmp_cnt_mod_mean = mean(tmp_cnt_mod);
tmp_cnt_mod_std = std(tmp_cnt_mod)/size(tmp_cnt_mod,1);

tmp_cnt_mod_thy1_mean = mean(tmp_cnt_mod_thy1);
tmp_cnt_mod_thy1_std = std(tmp_cnt_mod_thy1)/size(tmp_cnt_mod_thy1,1);

tmp_plt_mod_mean = [tmp_cnt_mod_mean tmp_cnt_mod_thy1_mean];
tmp_plt_mod_std = [tmp_cnt_mod_std tmp_cnt_mod_thy1_std];

figure
bar(tmp_plt_mod_mean);
hold on
errorbar(tmp_plt_mod_mean,tmp_plt_mod_std)
set(gcf,'color','w');
ylim([0 1])


tmp_cnt_mod = [];
for m = 1:size(Mdata,2)
    tmp_mod = Mdata{m}.mod_sort_do.unsort_sign;
    for s = 1:size(tmp_mod,2)
        tmp_cnt_mod(m,s) = length(find(tmp_mod{s} == 1))/length(tmp_mod{s});
    end
end
tmp_cnt_mod_thy1 = [];
for m = 1:size(Mdata_thy1,2)
    tmp_mod = Mdata_thy1{m}.mod_sort_do.unsort_sign;
    for s = 1:size(tmp_mod,2)
        tmp_cnt_mod_thy1(m,s) = length(find(tmp_mod{s} == 1))/length(tmp_mod{s});
    end
end

tmp_cnt_mod_mean = mean(tmp_cnt_mod);
tmp_cnt_mod_std = std(tmp_cnt_mod)/size(tmp_cnt_mod,1);

tmp_cnt_mod_thy1_mean = mean(tmp_cnt_mod_thy1);
tmp_cnt_mod_thy1_std = std(tmp_cnt_mod_thy1)/size(tmp_cnt_mod_thy1,1);

tmp_plt_mod_mean = [tmp_cnt_mod_mean tmp_cnt_mod_thy1_mean];
tmp_plt_mod_std = [tmp_cnt_mod_std tmp_cnt_mod_thy1_std];

% tmp_plt_mod_mean = tmp_cnt_mod_mean;
% tmp_plt_mod_std = tmp_cnt_mod_std;

figure
bar(tmp_plt_mod_mean);
hold on
errorbar(tmp_plt_mod_mean,tmp_plt_mod_std)
set(gcf,'color','w');
ylim([0 0.3])


tmp_cnt_mod = [];
for m = 1:size(Mdata,2)
    tmp_mod = Mdata{m}.mod_sort_pt.unsort_sign;
    for s = 1:size(tmp_mod,2)
        tmp_cnt_mod(m,s) = length(find(tmp_mod{s} == 1))/length(tmp_mod{s});
    end
end
tmp_cnt_mod_thy1 = [];
for m = 1:size(Mdata_thy1,2)
    tmp_mod = Mdata_thy1{m}.mod_sort_pt.unsort_sign;
    for s = 1:size(tmp_mod,2)
        tmp_cnt_mod_thy1(m,s) = length(find(tmp_mod{s} == 1))/length(tmp_mod{s});
    end
end

tmp_cnt_mod_mean = mean(tmp_cnt_mod);
tmp_cnt_mod_std = std(tmp_cnt_mod)/size(tmp_cnt_mod,1);

tmp_cnt_mod_thy1_mean = mean(tmp_cnt_mod_thy1);
tmp_cnt_mod_thy1_std = std(tmp_cnt_mod_thy1)/size(tmp_cnt_mod_thy1,1);

% tmp_plt_mod_mean = [tmp_cnt_mod_mean tmp_cnt_mod_thy1_mean];
% tmp_plt_mod_std = [tmp_cnt_mod_std tmp_cnt_mod_thy1_std];

tmp_plt_mod_mean = tmp_cnt_mod_mean;
tmp_plt_mod_std = tmp_cnt_mod_std;

figure
bar(tmp_plt_mod_mean);
hold on
errorbar(tmp_plt_mod_mean,tmp_plt_mod_std)
set(gcf,'color','w');
ylim([0 0.6])
