% mod and Wmod tiling sorting
function out = mod_tiling_1input(mod, mean_ca2)
    [tmp tmp_midx]= max(mean_ca2,[],2);
    tmp_idx = tmp_midx - mod'*10000;
    tmp_mod = mod;
    tmp_ridx = 1:length(tmp_idx);
    [tmp tmp_sort_idx] = sort(tmp_idx);
    tmp_sort_idx(find(tmp > 0)) = [];
    tmp_ridx(find(tmp_mod >0)) = [];
    out = [tmp_sort_idx' tmp_ridx];
end