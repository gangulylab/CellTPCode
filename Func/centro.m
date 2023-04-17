function centroid = centro(pfile,num_cell)
cell_set = isx.CellSet.read(pfile);    
    for i = 1:num_cell
        cell_image = double(cell_set.get_cell_image_data(i-1));
        cell_image = cell_image.*(cell_image>(0.8*max(cell_image(:))));
        num_pixels = cell_set.spacing.num_pixels;
        [X,Y] = meshgrid(0.5:num_pixels(2), 0.5:num_pixels(1));
        centroid(i,:) = [X(:), Y(:)]'*cell_image(:)/sum(cell_image(:));

    end

end