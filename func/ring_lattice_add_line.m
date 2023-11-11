function out = ring_lattice_add_line(A, mod_idx,rt_col)

    mod_n = find(mod_idx == 1);
    try
    %# 60-by-60 sparse adjacency matrix
    N = length(A);

    %# x/y coordinates of nodes in a circular layout
    r =  1;
    theta = linspace(0,2*pi,N+1)'; theta(end) = [];
    xy = r .* [cos(theta) sin(theta)];

    %# show nodes and edges
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