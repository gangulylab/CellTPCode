% spatial average with mask map
function [spavr, mask_f] = spaverimg(img_in,mask_in,x_in,y_in,sp_size)
%img_in: tiff_data (y,x,time)
%mask_in: mask (y,x)
%x_in: x coordinate
%y_in: y coordinate
%sp_size: spatial average range
%spavr: spatial average result
    tmp_mask = zeros(size(mask_in));
    tmp_mask(y_in-sp_size:y_in+sp_size,x_in-sp_size:x_in+sp_size) = 1;
    mask_f = mask_in.*tmp_mask;
    [mask_y,mask_x] = find(mask_f ==1);
    spavr = reshape(mean(img_in(mask_y,mask_x,:),[1,2]),1,size(img_in,3));




end