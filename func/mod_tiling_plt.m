function out = mod_tiling_plt(x_in,mod,t_dpoint)
% Tiling plot of modulated cells only, range-normalized and sorted by peak time.
% Returns the sort order.
    tmp_mod_data = x_in(find(mod == 1),:);
    tmp_mod_data = normalize(tmp_mod_data,2,'range');
    [~, tmp_idx] = max(tmp_mod_data,[],2);
    [~, tmp_so_idx] = sort(tmp_idx);

    imagesc(t_dpoint, [], tmp_mod_data(tmp_so_idx,:))
    out = tmp_so_idx;
end

