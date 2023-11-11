function out = nfold_pca(Mdata,sample_pca)
fold = 2;
    for m = 1:size(Mdata,2)
        tmp_Mdata = Mdata{m};
        clear ca2data_reaching Mpca
        ca2data_reaching = tmp_Mdata.ca2data_reaching;

        for s = 1:size(tmp_Mdata.ca2data_reaching,2)
            
            tmp_dl = size(ca2data_reaching{s},1);
            for kf = 1:fold

                s_size = floor(tmp_dl/fold);
                tr_t = (kf-1)*s_size+1:kf*s_size;
                tr_l = 1:tmp_dl;
                tr_l(tr_t) = [];


            %     tmp_pca_mean = squeeze(mean(zscore(ca2data_reaching{s},[],3)));  %choose zsocred
                tmp_pca_mean = squeeze(mean(ca2data_reaching{s}(tr_l,:,:)));   %choose
                tmp_pca_mean = tmp_pca_mean(:,sample_pca(1):sample_pca(2));
                

                [Mpca.coeff{s,kf},Mpca.score{s,kf},Mpca.latent{s,kf},Mpca.tsquared{s,kf},Mpca.explained{s}(kf,:),Mpca.mu{s,kf}] = pca(tmp_pca_mean');
                tmp_pca_tr = squeeze(mean(ca2data_reaching{s}(tr_t,:,:)));
                Mpca.LOOV{s}(kf,:,:) = Mpca.coeff{s,kf}'*tmp_pca_tr(:,sample_pca(1):sample_pca(2));


            end

        end

        out{m} = Mpca;

    end

end

