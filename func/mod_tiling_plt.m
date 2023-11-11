function out = mod_tiling_plt(x_in,mod,t_dpoint)
    tmp_mod_data = x_in(find(mod == 1),:);
    tmp_mod_data = normalize(tmp_mod_data,2,'range');
    [tmp_val tmp_idx] = max(tmp_mod_data,[],2);
    [tmp_so_val tmp_so_idx] = sort(tmp_idx);
    
    imagesc(t_dpoint, [], tmp_mod_data(tmp_so_idx,:))
    out = tmp_so_idx;
end

