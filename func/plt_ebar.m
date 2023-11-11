function out = plt_ebar(x_in)

    plt_mean = mean(x_in,'omitnan');
    plt_std = std(x_in,'omitnan')/sqrt(size(x_in,1));
    bar(plt_mean);
    hold on
    errorbar(plt_mean,plt_std);
    out = 1;
    ylim([0 0.9]);
end