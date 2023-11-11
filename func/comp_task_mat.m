function out = comp_task_mat(x_in, x_in_residual, t_cal, t_target, pre_win, post_win)
    if size(x_in_residual,2)>0
        base_size = 10;
        tmp_gpio_touch = t_target;
        tmp_accdata = x_in;
        tmp_residual = x_in_residual;
        for i = 1:size(tmp_gpio_touch,1)
            [c1 index1] = min(abs(t_cal-(tmp_gpio_touch(i))));
            t_idx_reaching(i) = index1;
        end
        tmp_rej = [];
        for j = 1: size(tmp_gpio_touch,1)
            try
                tmp_data_arigned = tmp_accdata(:,t_idx_reaching(j)-pre_win:t_idx_reaching(j)+post_win);
                tmp_base = std(tmp_residual(:,t_idx_reaching(j)-pre_win:t_idx_reaching(j)-pre_win+base_size),[],2);
                tmp_rep_base = repmat(tmp_base,1,size(tmp_data_arigned,2));

                tmp_out(j,:,:) = tmp_data_arigned./tmp_rep_base;
            catch
                tmp_rej = [tmp_rej j];

            end


        end
    else
    
        base_size = 10;
        tmp_gpio_touch = t_target;
        tmp_accdata = x_in;
        for i = 1:size(tmp_gpio_touch,1)
            [c1 index1] = min(abs(t_cal-(tmp_gpio_touch(i))));
            t_idx_reaching(i) = index1;
        end
        tmp_rej = [];
        for j = 1: size(tmp_gpio_touch,1)
            try
                tmp_data_arigned = tmp_accdata(:,t_idx_reaching(j)-pre_win:t_idx_reaching(j)+post_win);
                tmp_out(j,:,:) = tmp_data_arigned;
            catch
                tmp_rej = [tmp_rej j];

            end


        end
    end
    out = tmp_out;
end