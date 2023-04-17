
tmp_acc = [];
for m = 1:size(Mbf,2)
    tmp_map = Mbf{m}.flow_speed_map_mean;
    tmp_map = reshape(tmp_map,1,[]);
    tmp_map(find(tmp_map ==0)) = [];
    BF_sp{m} = tmp_map;
    tmp_acc = [tmp_acc tmp_map];
end

figure
h1 = raincloud_plot(tmp_acc, 'color', [0 0 1]);
set(gcf,'color','w');

figure
h1 = raincloud_plot(tmp_acc(randperm(size(tmp_acc,2),1000)), 'box_on', 1, 'color', [0 0 1], 'bandwidth', 1, 'density_type', 'rash');
set(gcf,'color','w');

figure
h1 = raincloud_plot(BF_sp{1}, 'box_on', 1, 'color', [0 0.5 1], 'alpha', 0.2,...
     'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .15,...
     'box_col_match', 0);
h2 = raincloud_plot(BF_sp{2}, 'box_on', 1, 'color', [1 0.5 0], 'alpha', 0.2,...
     'box_dodge', 1, 'box_dodge_amount', .35, 'dot_dodge_amount', .35, 'box_col_match', 0);
h3 = raincloud_plot(BF_sp{3}, 'box_on', 1, 'color', [0.5 1 0], 'alpha', 0.2,...
     'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', .55, 'box_col_match', 0);
h3 = raincloud_plot(BF_sp{4}, 'box_on', 1, 'color', [0.5 1 0.5], 'alpha', 0.2,...
     'box_dodge', 1, 'box_dodge_amount', .75, 'dot_dodge_amount', .75, 'box_col_match', 0);

legend([h1{1} h2{1} h3{1}], {'Early', 'Mid', 'Late'});
title(['Figure M7' newline 'A) Dodge Options Example 1']);
% set(gca,'XLim', [0 40], 'YLim', [-.075 .15]);
box off
set(gcf,'color','w');