function out = d2bin(x_in,range)
% Histogram counts of x_in over the bin edges in `range` (half-open bins).
    for b = 1:length(range)-1
        out(b) = length(find(x_in >=range(b) & x_in < range(b+1)));
    end
end

