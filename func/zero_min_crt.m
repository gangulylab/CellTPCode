function out = zero_min_crt(x_in)
% Shift each row of x_in so its minimum becomes zero.
    for i = 1:size(x_in,1)
        out(i,:) = x_in(i,:) - min(x_in(i,:));
    end
end

