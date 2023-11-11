function out = loov_pca(Mdata,sample_pca)
    for m = 1:size(Mdata,2)
        tmp_Mdata = Mdata{m};
        clear ca2data_reaching Mpca
        ca2data_reaching = tmp_Mdata.ca2data_reaching;
        
        for s = 1:size(tmp_Mdata.ca2data_reaching,2)
            tmp_mod_all = tmp_Mdata.mod_pt_do{s};
    
            tmp_mod_all(find(tmp_mod_all > 0)) = 1;
            tmp_dl = size(ca2data_reaching{s},1);
            for kf = 1:tmp_dl

                tr_t = kf;
                tr_l = 1:tmp_dl;
                tr_l(tr_t) = [];
                tmp_pca_mean = squeeze(mean(ca2data_reaching{s}(tr_l,:,:)));   %choose
                tmp_pca_mean = tmp_pca_mean(:,sample_pca(1):sample_pca(2));
                tmp_pca_mean(find(tmp_mod_all == 0),:) = [];  % comment out when non-mod filter needed


                [Mpca.coeff{s,kf},Mpca.score{s,kf},Mpca.latent{s,kf},Mpca.tsquared{s,kf},Mpca.explained{s}(kf,:),Mpca.mu{s,kf}] = pca(tmp_pca_mean');
                tmp_pca_tr = squeeze(ca2data_reaching{s}(tr_t,:,:));
                tmp_pca_tr(find(tmp_mod_all == 0),:) = [];  % comment out when non-mod filter needed
                Mpca.LOOV{s}(kf,:,:) = Mpca.coeff{s,kf}'*tmp_pca_tr;


            end

        end

        out{m} = Mpca;

    end

end

