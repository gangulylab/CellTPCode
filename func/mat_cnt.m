function out = mat_cnt(x_in,n_match)
    tmp_sum = sum(x_in);
    out = length(find(tmp_sum == n_match));
end

