function out = mod_cell2array(x_in)
% Collapse a cell array of per-cell modulation matrices to a vector holding
% each cell's minimum (smallest p-value) modulation value.
    for c = 1:size(x_in,2)
        tmp_mod = x_in{c};
        out(c) = min(tmp_mod,[],'all');
    end
end

