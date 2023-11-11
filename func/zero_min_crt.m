function out = zero_min_crt(x_in)
    for i = 1:size(x_in,1)
        out(i,:) = x_in(i,:) - min(x_in(i,:));
    end
end

