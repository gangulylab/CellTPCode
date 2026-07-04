function out = ring_lattice_add_line(A, mod_idx,rt_col)
% Overlay only the edges of adjacency matrix A onto an existing circular node
% layout (color rt_col), without redrawing the nodes. Returns 1/0 on
% success/failure.
    mod_n = find(mod_idx == 1);
    try
    N = length(A);

    % Circular node coordinates
    r =  1;
    theta = linspace(0,2*pi,N+1)'; theta(end) = [];
    xy = r .* [cos(theta) sin(theta)];

    % Draw an edge for every nonzero entry of A
    for i = 1:size(A,1)
        for j = 1:size(A,2)
            if A(i,j)>0
                plot([xy(i,1) xy(j,1)],[xy(i,2) xy(j,2)],rt_col)
            end
        end
    end


    out = 1;

    catch
        out = 0;
    end

end