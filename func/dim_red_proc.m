function recomb = dim_red_proc(x_in,dim)
    [x_coeff,x_score,x_latent] = pca(x_in);
    recomb = x_score(:,1:dim) * x_coeff(1:dim,:);
end

