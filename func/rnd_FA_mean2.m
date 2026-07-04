function [lambda,psi,out_T,stats,F] = rnd_FA_mean2(x_in,fa_dim_in,dim_in)
% Factor analysis on a single random subset of dim_in columns of x_in.
% Single-draw version of rnd_FA_mean.
    rnd = randperm(size(x_in,2),dim_in);
    [tmp_lambda,tmp_psi,tmp_T,stats,tmp_F] = factoran(x_in(:,rnd),2,'Rotate','none');

    lambda = tmp_lambda;
    psi    = tmp_psi;
    out_T  = tmp_T;
    F      = tmp_F;
end

