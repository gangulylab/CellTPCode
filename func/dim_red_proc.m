function recomb = dim_red_proc(x_in,dim)
% Reconstruct x_in from its first `dim` principal components (denoising).
    [x_coeff,x_score] = pca(x_in);
    recomb = x_score(:,1:dim) * x_coeff(1:dim,:);
end

