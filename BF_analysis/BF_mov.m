% foname = 'C:\Users\Kyungsoo Kim\Box\Transplant_Data\Blood Flow\save_mat\';
foname = 'C:\Users\chopa\Box\Transplant_Data\Blood Flow\save_mat\';
finame = 'M150.mat';
load([foname finame]);


plt_offset = 400;
clims = [0.025 0.08];
plt_data = movstd(tiff_data(:,:,plt_offset+1:plt_offset+600),10,[],3);

figure
imagesc(transpose(max(plt_data,[],3)))

set(gca,'XDir','reverse')
figure
for i = 1:size(plt_data,3)
    imagesc(squeeze(plt_data(:,:,i)),clims);
    set(gca,'XDir','reverse')
    pause(0.1);
   
end
t_point = 800:1400;
v = VideoWriter('BF_mov.avi');
v.FrameRate = 60;
open(v);
figure
for i = 1:size(plt_data,3)
    imagesc(squeeze(plt_data(:,:,i)),clims);
    set(gca,'XDir','reverse')
    colormap gray
    frame = getframe(gcf);
    writeVideo(v,frame);
   
end

close(v);