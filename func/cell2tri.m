function idx = cell2tri(size_1, size_2 ,idx_in)
% Expand a per-cell vector idx_in (length size_2) so each value is repeated
% size_1 times (once per trial), matching cell2tri_data's row order.
    idx = [];
    for c = 1:size_2
        tmp_idx = ones(1,size_1)*idx_in(c);
        idx = [idx tmp_idx];
    end
end