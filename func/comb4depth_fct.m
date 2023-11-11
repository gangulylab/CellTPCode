function Mdata_comb = comb4depth_fct(Mdata_app,size_in)
    um_x = 950/1280;
    um_y = 600/800;
    um_avr = mean([um_x um_y]);
    for s = 1:size_in
        tmp_comb_depth = [];
        tmp_comb_idx = [];
        tmp_comb_event = [];
        tmp_comb_mod = [];
        for m = 1:size(Mdata_app,2)
            try
            tmp_event = Mdata_app{m}.event_cmp_cnt{s};
            catch
                tmp_event = Mdata_app{m}.event_cmp_cnt;
            end
            tmp_depth = Mdata_app{m}.cont.coodnt{s}(:,2)*um_avr;
            tmp_idx = [ones(1,length(tmp_depth))*m; 1:length(tmp_depth)];
            tmp_mod = Mdata_app{m}.mod_pt_do{s}; 
            tmp_comb_depth = [tmp_comb_depth tmp_depth'];
            tmp_comb_idx = [tmp_comb_idx tmp_idx];
            tmp_comb_event = [tmp_comb_event; tmp_event];
            tmp_comb_mod = [tmp_comb_mod tmp_mod];

        end
        Mdata_comb{s}.depth = tmp_comb_depth;
        Mdata_comb{s}.idx = tmp_comb_idx;
        Mdata_comb{s}.event = tmp_comb_event;
        Mdata_comb{s}.mod = tmp_comb_mod;

    end
    
    
    
    Mdata_in = Mdata_comb;



try
    figure
    for s = 1:size(Mdata_in,2)
        tmp_depth = Mdata_in{s}.depth;
        tmp_idx = Mdata_in{s}.idx;
        tmp_event = Mdata_in{s}.event;
        tmp_mod = Mdata_in{s}.mod;
        tmp_diff = tmp_event(:,2) ./ tmp_event(:,1);
        tmp_plt = [tmp_depth' tmp_diff];
        subplot(1,3,s)
        scatter(tmp_plt(find(tmp_mod == 0),1),tmp_plt(find(tmp_mod == 0),2))
        hold on
        scatter(tmp_plt(find(tmp_mod == 1),1),tmp_plt(find(tmp_mod == 1),2), 'filled')
        ylim([0 20])
        set(gcf,'color','w');
        ylabel('Event increased')
    end
catch
    
    
end

    figure
    for s = 2
        tmp_depth = Mdata_in{s}.depth;
        tmp_idx = Mdata_in{s}.idx;
        tmp_event = Mdata_in{s}.event;
        tmp_mod = Mdata_in{s}.mod;
        tmp_diff = tmp_event(:,2) ./ tmp_event(:,1);
        tmp_plt = [tmp_depth' tmp_diff];
        scatter(tmp_plt(find(tmp_mod == 0),1),tmp_plt(find(tmp_mod == 0),2))
        hold on
        scatter(tmp_plt(find(tmp_mod == 1),1),tmp_plt(find(tmp_mod == 1),2), 'filled')
%         ylim([-10 10])
        set(gcf,'color','w');
        ylabel('Event increased')
    end
end