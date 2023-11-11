function out = ring_lattice_v2(A, mod_idx)

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
        'Marker','.', 'MarkerSize',15, 'Color','blue')
    hold on
    scatter(xy(mod_n,1), xy(mod_n,2), 'filled')
    
    %# show nodes and edges
    for i = 1:size(A,1)
        for j = 1:size(A,2)
            if A(i,j)>0
                try
                plot([xy(i,1) xy(j,1)],[xy(i,2) xy(j,2)],'Color', [0 0 0], 'LineWidth', A(i,j)*3)
                end
            end
        end
    end
    
    axis([-1 1 -1 1]); axis equal off
    hold off

    out = 1;

    catch
        out = 0;
    end

end