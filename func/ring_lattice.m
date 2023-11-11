function out = ring_lattice(A, mod_idx,rt_col)

    mod_n = find(mod_idx == 1);
    try
    %# 60-by-60 sparse adjacency matrix
    N = length(A);

    %# x/y coordinates of nodes in a circular layout
    r =  1;
    theta = linspace(0,2*pi,N+1)'; theta(end) = [];
    xy = r .* [cos(theta) sin(theta)];

    %# show nodes and edges
    line(xy(:,1), xy(:,2), 'LineStyle','none', ...
        'Marker','.', 'MarkerSize',15, 'Color',rt_col)
    hold on
    scatter(xy(mod_n,1), xy(mod_n,2), 'filled')
    gplot(A, xy, 'b-')
    axis([-1 1 -1 1]); axis equal off
    hold off

    out = 1;

    catch
        out = 0;
    end

end