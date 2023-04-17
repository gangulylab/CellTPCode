clear all
close all

% name = {'m98', 'm107', 'm118', 'm150'};
name = {'m98', 'm107', 'm150'};
bf_dist = [];
for i = 1:size(name,2)
    load(name{i})
    bf_dist = [bf_dist cent_min_dist];
end
histogram(bf_dist,30)
xlabel('minimum distance from BB')
set(gcf,'color','w');


tmp_hist = histogram(bf_dist,30);
bar(tmp_hist.BinEdges(1:end-1),tmp_hist.Values/sum(tmp_hist.Values))

figure
h1 = raincloud_plot(bf_dist, 'box_on', 1, 'color', [0 0 1], 'alpha', 0.5,...
     'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .15,...
     'box_col_match', 0);
h2 = raincloud_plot(tmp_hist_rain{2}, 'box_on', 1, 'color', [1 0 0], 'alpha', 0.5,...
     'box_dodge', 1, 'box_dodge_amount', .35, 'dot_dodge_amount', .35, 'box_col_match', 0);
h3 = raincloud_plot(tmp_hist_rain{3}, 'box_on', 1, 'color', [0 1 0], 'alpha', 0.5,...
     'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', .55, 'box_col_match', 0);

legend([h1{1} h2{1} h3{1}], {'Early', 'Mid', 'Late'});
title(['Figure M7' newline 'A) Dodge Options Example 1']);
% set(gca,'XLim', [0 40], 'YLim', [-.075 .15]);
box off
set(gcf,'color','w');
figure
h2 = raincloud_plot(bf_dist, 'box_on', 1, 'color', [0 0 1], 'bandwidth', 1, 'density_type', 'rash');
set(gcf,'color','w');
xlim([0 180])