function out = ring_lattice_v2(A, mod_idx)
% Circular connectivity graph with edge width scaled by connection strength
% (A(i,j)*3) and modulated nodes drawn filled. Returns 1/0 on success/failure.
    mod_n = find(mod_idx == 1);
    try
    N = length(A);

    % Circular node coordinates
    r =  1;
    theta = linspace(0,2*pi,N+1)'; theta(end) = [];
    xy = r .* [cos(theta) sin(theta)];

    % Nodes
    line(xy(:,1), xy(:,2), 'LineStyle','none', ...
        'Marker','.', 'MarkerSize',15, 'Color','blue')
    hold on
    scatter(xy(mod_n,1), xy(mod_n,2), 'filled')

    % Weighted edges
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