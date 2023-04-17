%% load tiff file
t = Tiff('C:\Users\chopa\Box\Transplant_Data\Blood Flow\M98\M98_bf_edited.tif','r');
ca_max = read(t);
ca_max = squeeze(mean(ca_max,3));
figure
imagesc(ca_max)
colormap('gray')


v_fil = 3;
filt1 = ones(v_fil,v_fil)/v_fil^2;
conv_ca_mean = conv2(ca_max,filt1);
figure
imagesc(conv_ca_mean);

conv_ca_max = conv2(ca_max,filt1);
figure
imagesc(conv_ca_max);


median_ca = medfilt2(ca_max,[5 5]);
figure
imagesc(median_ca)




thres = 0.455;
v_max = max(ca_max,[],'all');

ca_max2 = ca_max;
ca_max2(find(ca_max < thres*v_max)) = 0;
figure
imagesc(ca_max2)



median_ca(find(ca_max < thres*v_max)) = 0;

-

conv_ca_max = conv2(ca_max,filt1);
conv_ca_max(find(conv_ca_max < thres*v_max)) = 0;

figure
imagesc(conv_ca_max)