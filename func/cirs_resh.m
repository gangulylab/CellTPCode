function out = cirs_resh(tmp_data,k)
% Reshape a [trial x cell x time] array to [time*trial x cell], optionally
% circularly shifting each cell's trials in time by a random amount up to +/-k
% (k <= 0 leaves the data unshifted). Used to build trial-shuffled surrogates.
    for c = 1:size(tmp_data,2)
        if k > 0
            tmp_data_tr_t = circshift(squeeze(tmp_data(:,c,:)), round(randi(k*2)-k),2);
        else
            tmp_data_tr_t = squeeze(tmp_data(:,c,:));
        end
        out(:,c) = reshape(tmp_data_tr_t', 1,[])';
    end
end