function out = mod_tiling_1input(mod, mean_ca2)
% Order cells for tiling plots: modulated cells (mod > 0) are sorted by peak
% time and returned first, followed by the remaining (non-modulated) cells.
    [~, tmp_midx] = max(mean_ca2,[],2);
    % Offset modulated cells to negative values so they sort ahead
    tmp_idx  = tmp_midx - mod'*10000;
    tmp_mod  = mod;
    tmp_ridx = 1:length(tmp_idx);
    [tmp, tmp_sort_idx] = sort(tmp_idx);
    tmp_sort_idx(find(tmp > 0)) = [];   % keep only modulated cells (negative keys)
    tmp_ridx(find(tmp_mod > 0)) = [];   % remaining non-modulated cells
    out = [tmp_sort_idx' tmp_ridx];
end