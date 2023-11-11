function out = loov_nnmf(Mdata,sample_pca)
fold = 5;
    for m = 1:size(Mdata,2)
        tmp_Mdata = Mdata{m};
        clear ca2data_reaching Mnnmf
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
                

                [Mnnmf.coeff{s,kf},Mnnmf.score{s,kf}] = nnmf(tmp_pca_mean,2);
                tmp_pca_tr = squeeze(mean(ca2data_reaching{s}(tr_t,:,:)));
                Mnnmf.LOOV{s}(kf,:,:) = Mnnmf.coeff{s,kf}'*tmp_pca_tr(:,sample_pca(1):sample_pca(2));


            end

        end

        out{m} = Mnnmf;

    end

end

