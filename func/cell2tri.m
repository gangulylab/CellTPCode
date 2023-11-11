function idx = cell2tri(size_1, size_2 ,idx_in)
    idx = [];
    for c = 1:size_2
        tmp_idx = ones(1,size_1)*idx_in(c);
        idx = [idx tmp_idx];
    end
end