function data = cell2tri_data(x_in)
    data = [];
    for c = 1:size(x_in,2)
        tmp_data = squeeze(x_in(:,c,:));
        data = [data; tmp_data];

    end
end