function out = plt_cell_loc(Mdata,plt_m)
% um conversion
um_x = 950/1280;
um_y = 600/800;
um_avr = mean([um_x um_y]);


    figure
    k = 0;
    for m = 1:size(Mdata,2)
        for s = 1:size(Mdata{m}.cont.coodnt,2)
            tmp_mod = Mdata{m}.mod_pt_do{s};
            k = k+1;
            tmp_loc = Mdata{m}.cont.coodnt{s}*um_avr;
            subplot(size(Mdata,2),size(Mdata{m}.cont.coodnt,2),k)
            tmp_idx_mod = find(tmp_mod == 1);
            tmp_idx_Nmod = find(tmp_mod == 0);
            scatter(-tmp_loc(tmp_idx_mod,1),-tmp_loc(tmp_idx_mod,2),'filled');
            hold on
            scatter(-tmp_loc(tmp_idx_Nmod,1),-tmp_loc(tmp_idx_Nmod,2));
        xlim([-600 0]);
        ylim([-800 0]);
        end
        
    end
    
    figure
    m = plt_m;
    
    for s = 1:size(Mdata{m}.cont.coodnt,2)
        tmp_mod = Mdata{m}.mod_pt_do{s};
        k = k+1;
        tmp_loc = Mdata{m}.cont.coodnt{s}*um_avr;
        subplot(1,size(Mdata{m}.cont.coodnt,2),s)
        tmp_idx_mod = find(tmp_mod == 1);
        tmp_idx_Nmod = find(tmp_mod == 0);
        scatter(-tmp_loc(tmp_idx_mod,1),-tmp_loc(tmp_idx_mod,2),'filled');
        hold on
        scatter(-tmp_loc(tmp_idx_Nmod,1),-tmp_loc(tmp_idx_Nmod,2));
        xlim([-600 0]);
        ylim([-800 0]);
    end
    
    out = 1;
end
