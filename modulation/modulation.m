%% modulation analysis by significance check
% modulation anlaysis by ANOVA
% in review mod % changed to mod number
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
        
        tmp_mod_sort_do = mod_proc(Mdata{m}.ca2data_do{s},mod_bin_do);
        Mdata{m}.mod_sort_do.ca2data_mod{s,:} = tmp_mod_sort_do.ca2data_mod;
        Mdata{m}.mod_sort_do.unsort_sign{s} = tmp_mod_sort_do.unsort_sign;
        Mdata{m}.mod_sort_do.h{s,:} = tmp_mod_sort_do.h;
        Mdata{m}.mod_sort_do.mean_mat{s} = tmp_mod_sort_do.mean_mat;
        
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
    for i = 1:3
        k = k+1;
        subplot(ceil(sqrt(size(Mdata{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata{m}.ca2data_reaching,2)))*2,k)

        tmp_data = normalize(squeeze(mean(Mdata{m}.ca2data_reaching{i})),2,'range');
        tmp_mod_all = Mdata{m}.mod_pt_do{i};
        tmp_idx = mod_tiling_1input(tmp_mod_all,tmp_data);
        tmp_plt = tmp_mod_all';
        imagesc(t_dpoint,[],tmp_data(tmp_idx,:))
        title([num2str(m) 'do-pt'])
        k = k+1;
        subplot(ceil(sqrt(size(Mdata{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata{m}.ca2data_reaching,2)))*2,k)
        imagesc(tmp_plt(tmp_idx,:),clims);
    end
    
    figure
    %plot tiling for do
    clims = [0 1];
    k = 0;
    for i = 1:3
        k = k+1;
        subplot(ceil(sqrt(size(Mdata{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata{m}.ca2data_reaching,2)))*2,k)
        tmp_data = normalize(squeeze(mean(Mdata{m}.ca2data_do{i})),2,'range');
        tmp_mod_all = Mdata{m}.mod_sort_do.unsort_sign{i};

        tmp_idx = mod_tiling_1input(tmp_mod_all,tmp_data);
        tmp_plt = tmp_mod_all';
        imagesc(t_dpoint,[],tmp_data(tmp_idx,:))
        title([num2str(m) 'do'])

        k = k+1;
        subplot(ceil(sqrt(size(Mdata{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata{m}.ca2data_reaching,2)))*2,k)
        imagesc(tmp_plt(tmp_idx,:),clims);
    end
    
    
    figure
    %plot tiling for do
    clims = [0 1];
    k = 0;

    for i = 1:3
        k = k+1;
        subplot(ceil(sqrt(size(Mdata{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata{m}.ca2data_reaching,2)))*2,k)

        tmp_data = normalize(squeeze(mean(Mdata{m}.ca2data_reaching{i})),2,'range');
        tmp_mod_all = Mdata{m}.mod_sort_pt.unsort_sign{i};

        tmp_idx = mod_tiling_1input(tmp_mod_all,tmp_data);

        tmp_plt = tmp_mod_all';
        imagesc(t_dpoint,[],tmp_data(tmp_idx,:))
        title([num2str(m) 'pt'])

        k = k+1;
        subplot(ceil(sqrt(size(Mdata{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata{m}.ca2data_reaching,2)))*2,k)
        imagesc(tmp_plt(tmp_idx,:),clims);
    end
    
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

        
        tmp_mod_sort_do = mod_proc(Mdata_thy1{m}.ca2data_do{s},mod_bin_do);
        Mdata_thy1{m}.mod_sort_do.ca2data_mod{s,:} = tmp_mod_sort_do.ca2data_mod;
        Mdata_thy1{m}.mod_sort_do.unsort_sign{s} = tmp_mod_sort_do.unsort_sign;
        Mdata_thy1{m}.mod_sort_do.h{s,:} = tmp_mod_sort_do.h;
        Mdata_thy1{m}.mod_sort_do.mean_mat{s} = tmp_mod_sort_do.mean_mat;

        
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

    for i = 1:size(Mdata_thy1{m}.ca2data_reaching,2)
        k = k+1;
        subplot(ceil(sqrt(size(Mdata_thy1{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata_thy1{m}.ca2data_reaching,2)))*2,k)

        tmp_data = normalize(squeeze(mean(Mdata_thy1{m}.ca2data_reaching{i})),2,'range');
        tmp_mod_all = Mdata_thy1{m}.mod_pt_do{i};

        tmp_idx = mod_tiling_1input(tmp_mod_all,tmp_data);

        tmp_plt = tmp_mod_all';
        imagesc(t_dpoint,[],tmp_data(tmp_idx,:))
        k = k+1;
        subplot(ceil(sqrt(size(Mdata_thy1{m}.ca2data_reaching,2))),ceil(sqrt(size(Mdata_thy1{m}.ca2data_reaching,2)))*2,k)
        imagesc(tmp_plt(tmp_idx,:),clims);
        title('thy1_healthy')
    end
end
tmp_cnt_mod = [];
for m = 1:size(Mdata,2)
    tmp_mod = Mdata{m}.mod_pt_do;
    for s = 1:size(tmp_mod,2)
        tmp_cnt_mod(m,s) = length(find(tmp_mod{s} >= 1))/length(tmp_mod{s});
    end
end
tmp_cnt_mod_thy1 = [];
for m = 1:size(Mdata_thy1,2)
    tmp_mod = Mdata_thy1{m}.mod_pt_do;
    for s = 1:size(tmp_mod,2)
        tmp_cnt_mod_thy1(m,s) = length(find(tmp_mod{s} >= 1))/length(tmp_mod{s});
    end
end

tmp_cnt_mod_mean = mean(tmp_cnt_mod);
tmp_cnt_mod_std = std(tmp_cnt_mod)/sqrt(size(tmp_cnt_mod,1));

tmp_cnt_mod_thy1_mean = mean(tmp_cnt_mod_thy1);
tmp_cnt_mod_thy1_std = std(tmp_cnt_mod_thy1)/sqrt(size(tmp_cnt_mod_thy1,1));

tmp_plt_mod_mean = [tmp_cnt_mod_mean tmp_cnt_mod_thy1_mean];
tmp_plt_mod_std = [tmp_cnt_mod_std tmp_cnt_mod_thy1_std];

figure
bar(tmp_plt_mod_mean);
hold on

for s = 1:size(tmp_cnt_mod,2)
    scatter(s*ones(1,size(tmp_cnt_mod,1)),tmp_cnt_mod(:,s), 15,'k', 'filled')
end
scatter(4*ones(1,size(tmp_cnt_mod_thy1,1)),tmp_cnt_mod_thy1, 15, 'k', 'filled')
errorbar(tmp_plt_mod_mean,tmp_plt_mod_std,'Color', [0.9290 0.6940 0.1250])
set(gcf,'color','w');
ylim([0 1])

tmp_cnt_mod = [];
for m = 1:size(Mdata,2)
    tmp_mod = Mdata{m}.mod_pt_do;
    for s = 1:size(tmp_mod,2)
        tmp_cnt_mod(m,s) = length(find(tmp_mod{s} == 1));
    end
end
tmp_cnt_mod_thy1 = [];
for m = 1:size(Mdata_thy1,2)
    tmp_mod = Mdata_thy1{m}.mod_pt_do;
    for s = 1:size(tmp_mod,2)
        tmp_cnt_mod_thy1(m,s) = length(find(tmp_mod{s} == 1));
    end
end

tmp_cnt_mod_mean = mean(tmp_cnt_mod);
tmp_cnt_mod_std = std(tmp_cnt_mod)/sqrt(size(tmp_cnt_mod,1));

tmp_cnt_mod_thy1_mean = mean(tmp_cnt_mod_thy1);
tmp_cnt_mod_thy1_std = std(tmp_cnt_mod_thy1)/sqrt(size(tmp_cnt_mod_thy1,1));


tmp_plt_mod_mean = [tmp_cnt_mod_mean tmp_cnt_mod_thy1_mean];
tmp_plt_mod_std = [tmp_cnt_mod_std tmp_cnt_mod_thy1_std];

figure
bar(tmp_cnt_mod_mean);
hold on
for s = 1:size(tmp_cnt_mod,2)
    scatter(s*ones(1,size(tmp_cnt_mod,1)),tmp_cnt_mod(:,s), 15,'k', 'filled')
end
scatter(4*ones(1,size(tmp_cnt_mod_thy1,1)),tmp_cnt_mod_thy1, 15, 'k', 'filled')
errorbar(tmp_cnt_mod_mean,tmp_cnt_mod_std)
set(gcf,'color','w');

ylabel('Number of modulated cells')
ylim([0 100])
xlim([0.2 3.8])



