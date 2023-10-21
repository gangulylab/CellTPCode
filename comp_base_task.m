%ca2reaching
base_size = 10;
for m = 1:size(Mdata,2)
    tmp_Mdata = Mdata{m};
    clear tmp_ca2*
    for s = 1:size(tmp_Mdata.pica_b.traces,2)
        tmp_gpio_touch = tmp_Mdata.gpio.touch{s};
        tmp_gpio_start = tmp_Mdata.gpio.start{s};
        t_cal = tmp_Mdata.pica_b.rtime{s};
        % do filtering
        tmp_gpio_min = [];
        for i = 1:length(tmp_gpio_start)
            tmp_gpio_min(i) = min(abs(tmp_gpio_touch - tmp_gpio_start(i)));
        end
        tmp_gpio_start(find(tmp_gpio_min < 0.5)) = [];
        
        tmp_ca2reach{s} = comp_task_mat(tmp_Mdata.pica_b.traces{s}, tmp_Mdata.pica_b.residual{s}, t_cal, tmp_gpio_touch, pre_win, post_win);
        tmp_ca2do{s} = comp_task_mat(tmp_Mdata.pica_b.traces{s}, tmp_Mdata.pica_b.residual{s}, t_cal, tmp_gpio_start, pre_win, post_win);
    end
    for s = 1:size(tmp_Mdata.pica_b.traces,2)
        try [tmp tmp_ca2reach{s}] = rm_outlier(tmp_ca2reach{s},5);end
    end
    Mdata{m}.ca2data_reaching = tmp_ca2reach;
    Mdata{m}.ca2data_do = tmp_ca2do;
end

for m = 1:size(Mdata_thy1,2)
    tmp_Mdata = Mdata_thy1{m};
    clear tmp_ca2*
    for s = 1:size(tmp_Mdata.pica_b.traces,2)
        tmp_gpio_touch = tmp_Mdata.gpio.touch{s};
        tmp_gpio_start = tmp_Mdata.gpio.start{s};
        % do filtering
        tmp_gpio_min = [];
        for i = 1:length(tmp_gpio_start)
            tmp_gpio_min(i) = min(abs(tmp_gpio_touch - tmp_gpio_start(i)));
        end
        tmp_gpio_start(find(tmp_gpio_min < 0.5)) = [];
        t_cal = tmp_Mdata.pica_b.rtime{s};
        tmp_ca2reach{s} = comp_task_mat(tmp_Mdata.pica_b.traces{s}, [], t_cal, tmp_gpio_touch, pre_win, post_win);
        tmp_ca2do{s} = comp_task_mat(tmp_Mdata.pica_b.traces{s}, [], t_cal, tmp_gpio_start, pre_win, post_win);
    
    end
    for s = 1:size(tmp_Mdata.pica_b.traces,2)
        try [tmp tmp_ca2reach{s}] = rm_outlier(tmp_ca2reach{s},5);end
    end
    Mdata_thy1{m}.ca2data_reaching = tmp_ca2reach;
    Mdata_thy1{m}.ca2data_do = tmp_ca2do;
end