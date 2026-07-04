function data = cell2tri_data(x_in)
% Flatten a [trial x cell x time] array to [(cell*trial) x time], stacking all
% trials of each cell in turn.
    data = [];
    for c = 1:size(x_in,2)
        tmp_data = squeeze(x_in(:,c,:));
        data = [data; tmp_data];
    end
end