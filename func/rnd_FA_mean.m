function [lambda,psi,out_T,stats,F] = rnd_FA_mean(x_in,fa_dim_in,dim_in)
    for i = 1:10
        rnd = randperm(size(x_in,2),dim_in);
        [tmp_lambda(i,:,:),tmp_psi(i,:),tmp_T(i,:,:),stats,tmp_F(i,:,:)] = factoran(x_in(:,rnd),2,'Rotate','none');
        
        
        
    end
    lambda = squeeze(mean(tmp_lambda));
    psi = squeeze(mean(tmp_psi));
    out_T = squeeze(mean(tmp_T));
    F = squeeze(mean(tmp_F));
    
end

