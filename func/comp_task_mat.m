function out = comp_task_mat(x_in, x_in_residual, t_cal, t_target, pre_win, post_win)
% Cut a [trial x cell x time] matrix from continuous traces around each event.
%   x_in          - cell x time trace matrix
%   x_in_residual - matching residual traces; if empty, no baseline normalization
%   t_cal         - time stamp for each trace sample
%   t_target      - event times to align to
%   pre_win/post_win - samples kept before/after each event
    base_size = 10;   % samples used to estimate the residual baseline

    % Map each event time to the nearest trace sample
    for i = 1:size(t_target,1)
        [~, index1] = min(abs(t_cal-t_target(i)));
        t_idx_reaching(i) = index1;
    end

    tmp_rej = [];
    if size(x_in_residual,2) > 0
        % Normalize each aligned window by the residual baseline std
        for j = 1:size(t_target,1)
            try
                tmp_data_arigned = x_in(:,t_idx_reaching(j)-pre_win:t_idx_reaching(j)+post_win);
                tmp_base = std(x_in_residual(:,t_idx_reaching(j)-pre_win:t_idx_reaching(j)-pre_win+base_size),[],2);
                tmp_rep_base = repmat(tmp_base,1,size(tmp_data_arigned,2));
                tmp_out(j,:,:) = tmp_data_arigned./tmp_rep_base;
            catch
                tmp_rej = [tmp_rej j];
            end
        end
    else
        % No residual: keep the raw aligned window
        for j = 1:size(t_target,1)
            try
                tmp_data_arigned = x_in(:,t_idx_reaching(j)-pre_win:t_idx_reaching(j)+post_win);
                tmp_out(j,:,:) = tmp_data_arigned;
            catch
                tmp_rej = [tmp_rej j];
            end
        end
    end
    out = tmp_out;
end