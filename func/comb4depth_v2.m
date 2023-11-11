function Mdata_comb = comb4depth(Mdata_app,size_in)
um_x = 950/1280;
um_y = 600/800;
um_avr = mean([um_x um_y]);
    for s = 1:size_in
        tmp_comb_depth = [];
        tmp_comb_idx = [];
        tmp_comb_ca2data = [];
        tmp_comb_mod = [];
        tmp_comb_mod_p = [];
        for m = 1:size(Mdata_app,2)
            try
            tmp_depth = Mdata_app{m}.cont.coodnt{s}(:,2)*um_avr;
            
            tmp_idx = [ones(1,length(tmp_depth))*m; 1:length(tmp_depth)];
            tmp_mod = Mdata_app{m}.mod_pt_do{s}; 
            
            tmp_comb_depth = [tmp_comb_depth tmp_depth'];
            tmp_comb_idx = [tmp_comb_idx tmp_idx];
            tmp_comb_mod = [tmp_comb_mod tmp_mod];
            
            tmp_mod_p = mod_cell2array(Mdata_app{m}.mod_sort_pt.ca2data_mod{s});
            tmp_comb_mod_p = [tmp_comb_mod_p tmp_mod_p];
            
            
            end
        end
        Mdata_comb{s}.depth = tmp_comb_depth;
        Mdata_comb{s}.idx = tmp_comb_idx;
        Mdata_comb{s}.mod_p = tmp_comb_mod_p;
        Mdata_comb{s}.mod = tmp_comb_mod;

    end


end