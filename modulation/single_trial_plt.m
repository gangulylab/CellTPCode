m = 5;
for s = 1:size(Mdata{m}.ca2data_reaching,2)
    tmp_ca2data = Mdata{m}.ca2data_reaching{s};
    tmp_mod = Mdata{m}.mod_pt_do{s};
    figure
    for i = 1:size(tmp_ca2data,1)
        subplot(ceil(sqrt(size(tmp_ca2data,1))),ceil(sqrt(size(tmp_ca2data,1)))+1,i)
        mod_tiling_plt(squeeze(tmp_ca2data(i,:,:)), tmp_mod, t_dpoint);
        title(num2str(i))
    end
    
end
figure
tmp_sel_tr = [7 16 24];
for s = 1:size(Mdata{m}.ca2data_reaching,2)
    tmp_ca2data = Mdata{m}.ca2data_reaching{s};
    tmp_mod = Mdata{m}.mod_pt_do{s};

    subplot(1,3,s)
    mod_tiling_plt(squeeze(tmp_ca2data(tmp_sel_tr(s),:,:)), tmp_mod, t_dpoint);

    
end


m = 2;
for s = 1:size(Mdata_thy1{m}.ca2data_reaching,2)
    tmp_ca2data = Mdata_thy1{m}.ca2data_reaching{s};
    tmp_mod = Mdata_thy1{m}.mod_pt_do{s};
    figure
    for i = 1:size(tmp_ca2data,1)
        subplot(ceil(sqrt(size(tmp_ca2data,1))),ceil(sqrt(size(tmp_ca2data,1)))+1,i)
        mod_tiling_plt(squeeze(tmp_ca2data(i,:,:)), tmp_mod, t_dpoint);
        title(num2str(i))
    end
    
end
figure
tmp_sel_tr = [30];
for s = 1:size(Mdata_thy1{m}.ca2data_reaching,2)
    tmp_ca2data = Mdata_thy1{m}.ca2data_reaching{s};
    tmp_mod = Mdata_thy1{m}.mod_pt_do{s};
    mod_tiling_plt(squeeze(tmp_ca2data(tmp_sel_tr(s),:,:)), tmp_mod, t_dpoint);

    
end