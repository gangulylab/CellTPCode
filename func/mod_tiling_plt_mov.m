function out = mod_tiling_plt_mov(x_in,mod,t_dpoint,i)
    tmp_base = zeros(size(x_in,1),length(t_dpoint));
%     tmp_mod_data = x_in(find(mod == 1),:);
    tmp_mod_data = x_in;
    tmp_mod_data = normalize(tmp_mod_data,2,'range');
    [tmp_val tmp_idx] = max(tmp_mod_data,[],2);
    [tmp_so_val tmp_so_idx] = sort(tmp_idx);
    
    tmp_plt = tmp_base;
%     tmp_plt(:,length(t_dpoint)-i+1:length(t_dpoint)) = tmp_mod_data(tmp_so_idx,1:i);
    tmp_plt(:,1:i) = tmp_mod_data(tmp_so_idx,1:i);
    imagesc(t_dpoint, [], tmp_plt)
    colormap hot
end

