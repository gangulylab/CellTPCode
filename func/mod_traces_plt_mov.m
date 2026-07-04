function out = mod_traces_plt_mov(x_in,mod,t_dpoint,i,cell_idx)
% Animation frame: stacked, range-normalized traces (peak-time sorted) for the
% selected cells, drawn up to time index i on a black background.
    tmp_mod_data = x_in;
    tmp_mod_data = normalize(tmp_mod_data,2,'range');
    [~, tmp_idx] = max(tmp_mod_data,[],2);
    [~, tmp_so_idx] = sort(tmp_idx);

    tmp_plt = tmp_mod_data(tmp_so_idx,1:i);
    j = 1;
    for k = cell_idx
        hold on
        plot(t_dpoint(1:i),tmp_plt(k,:)-(j-1)*1.5, 'w', 'LineWidth', 3);
        set(gca,'Color','k')
        xlim([-2.3 2])
        ylim([-10 2])
        j = j+1;
    end

end

