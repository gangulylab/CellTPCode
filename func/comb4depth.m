function [Mdata_comb, Mdata_comb_tr] = comb4depth(Mdata_app,size_in)
% Pool cells across animals by cortical depth and plot peak timing / amplitude
% against depth, split by modulation status.
%   Mdata_comb    - session-mean data per cell
%   Mdata_comb_tr - per-trial ("triangulated") data per cell
% Depth is converted from pixels to microns.
    um_x   = 950/1280;
    um_y   = 600/800;
    um_avr = mean([um_x um_y]);

    for s = 1:size_in
        % Session-mean data pooled across animals
        tmp_comb_depth   = [];
        tmp_comb_idx     = [];
        tmp_comb_ca2data = [];
        tmp_comb_mod     = [];
        for m = 1:size(Mdata_app,2)
            try
                tmp_depth   = Mdata_app{m}.cont.coodnt{s}(:,2)*um_avr;
                tmp_ca2data = squeeze(mean(Mdata_app{m}.ca2data_reaching{s}));
                tmp_idx     = [ones(1,length(tmp_depth))*m; 1:length(tmp_depth)];
                tmp_mod     = Mdata_app{m}.mod_pt_do{s};
                tmp_comb_depth   = [tmp_comb_depth tmp_depth'];
                tmp_comb_idx     = [tmp_comb_idx tmp_idx];
                tmp_comb_ca2data = [tmp_comb_ca2data; tmp_ca2data];
                tmp_comb_mod     = [tmp_comb_mod tmp_mod];
            end
        end
        Mdata_comb{s}.depth   = tmp_comb_depth;
        Mdata_comb{s}.idx     = tmp_comb_idx;
        Mdata_comb{s}.ca2data = tmp_comb_ca2data;
        Mdata_comb{s}.mod     = tmp_comb_mod;

        % Per-trial data pooled across animals (each cell repeated per trial)
        tmp_comb_depth   = [];
        tmp_comb_idx     = [];
        tmp_comb_ca2data = [];
        tmp_comb_mod     = [];
        for m = 1:size(Mdata_app,2)
            try
                tmp_depth_tri   = Mdata_app{m}.cont.coodnt{s}(:,2)*um_avr;
                tmp_idx_tri     = [ones(1,length(tmp_depth_tri))*m; 1:length(tmp_depth_tri)];
                tmp_mod_tri     = Mdata_app{m}.mod_pt_do{s};
                tmp_ca2data_tri = Mdata_app{m}.ca2data_reaching{s};
                tmp_idx = [];
                tmp_depth = cell2tri(size(tmp_ca2data_tri,1),size(tmp_ca2data_tri,2),tmp_depth_tri);
                tmp_mod   = cell2tri(size(tmp_ca2data_tri,1),size(tmp_ca2data_tri,2),tmp_mod_tri);
                tmp_idx(1,:) = cell2tri(size(tmp_ca2data_tri,1),size(tmp_ca2data_tri,2),tmp_idx_tri(1,:));
                tmp_idx(2,:) = cell2tri(size(tmp_ca2data_tri,1),size(tmp_ca2data_tri,2),tmp_idx_tri(2,:));
                tmp_ca2data  = cell2tri_data(tmp_ca2data_tri);

                tmp_comb_depth   = [tmp_comb_depth tmp_depth];
                tmp_comb_idx     = [tmp_comb_idx tmp_idx];
                tmp_comb_ca2data = [tmp_comb_ca2data; tmp_ca2data];
                tmp_comb_mod     = [tmp_comb_mod tmp_mod];
            end
        end
        Mdata_comb_tr{s}.depth   = tmp_comb_depth;
        Mdata_comb_tr{s}.idx     = tmp_comb_idx;
        Mdata_comb_tr{s}.ca2data = tmp_comb_ca2data;
        Mdata_comb_tr{s}.mod     = tmp_comb_mod;
    end

    % Session-mean: peak delay vs depth
    Mdata_in = Mdata_comb;
    figure
    for s = 1:size(Mdata_in,2)
        tmp_depth   = Mdata_in{s}.depth;
        tmp_ca2data = Mdata_in{s}.ca2data;
        tmp_mod     = Mdata_in{s}.mod;
        [~, tmp_pdelay] = max(tmp_ca2data,[],2);
        tmp_plt = [tmp_depth' tmp_pdelay/10-5];
        subplot(1,3,s)
        scatter(tmp_plt(find(tmp_mod == 0),1),tmp_plt(find(tmp_mod == 0),2))
        hold on
        scatter(tmp_plt(find(tmp_mod == 1),1),tmp_plt(find(tmp_mod == 1),2), 'filled')
    end

    % Session-mean: peak amplitude vs depth
    figure
    for s = 1:size(Mdata_in,2)
        tmp_depth   = Mdata_in{s}.depth;
        tmp_ca2data = Mdata_in{s}.ca2data;
        tmp_mod     = Mdata_in{s}.mod;
        [tmp_pamp, ~] = max(tmp_ca2data,[],2);
        tmp_plt = [tmp_depth' tmp_pamp];
        subplot(1,3,s)
        scatter(tmp_plt(find(tmp_mod == 0),1),tmp_plt(find(tmp_mod == 0),2))
        hold on
        scatter(tmp_plt(find(tmp_mod == 1),1),tmp_plt(find(tmp_mod == 1),2), 'filled')
    end

    % Per-trial: peak delay vs depth
    Mdata_in = Mdata_comb_tr;
    figure
    for s = 1:size(Mdata_in,2)
        tmp_depth   = Mdata_in{s}.depth;
        tmp_ca2data = Mdata_in{s}.ca2data;
        tmp_mod     = Mdata_in{s}.mod;
        [~, tmp_pdelay] = max(tmp_ca2data,[],2);
        tmp_plt = [tmp_depth' tmp_pdelay/10-5];
        subplot(1,3,s)
        scatter(tmp_plt(find(tmp_mod == 0),1),tmp_plt(find(tmp_mod == 0),2))
        hold on
        scatter(tmp_plt(find(tmp_mod == 1),1),tmp_plt(find(tmp_mod == 1),2), 'filled')
    end

    % Per-trial: peak amplitude vs depth
    figure
    for s = 1:size(Mdata_in,2)
        tmp_depth   = Mdata_in{s}.depth;
        tmp_ca2data = Mdata_in{s}.ca2data;
        tmp_mod     = Mdata_in{s}.mod;
        [tmp_pamp, ~] = max(tmp_ca2data,[],2);
        tmp_plt = [tmp_depth' tmp_pamp];
        subplot(1,3,s)
        scatter(tmp_plt(find(tmp_mod == 0),1),tmp_plt(find(tmp_mod == 0),2))
        hold on
        scatter(tmp_plt(find(tmp_mod == 1),1),tmp_plt(find(tmp_mod == 1),2), 'filled')
    end

end
