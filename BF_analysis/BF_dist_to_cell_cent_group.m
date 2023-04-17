%%load cell cent
clear all
close all

um_x = 1050/1280;
um_y = 650/800;
um_avr = mean([um_x um_y]);
%M98
foname = 'C:\Users\chopa\Box\Transplant_Data\Caiman\Behavior\M98_syn\mat\';
finamePickle = '2021-12-02_pickle.mat';

% foname = 'C:\Users\Kyungsoo Kim\Box\Transplant_Data\Caiman\Behavior\M150_syn\mat_ext\';
% finamePickle = '2022-06-24_pickle.mat';

mname = {'M98','M107','M150'};
% mname = {'M98','M107','M118'};
foname = 'C:\Users\chopa\Box\Transplant_Data\Blood Flow\';


for m = 1:size(mname,2)
    t = Tiff([foname 'max_projection\' mname{m} '_BF_edited.tif'],'r');%load max projection
    ca_max = read(t);
    ca_max = squeeze(mean(ca_max,3))/double(max(ca_max,[],'all'));
    Mbf{m}.maxP = ca_max;
    
    
    
end

tmp_load = load([foname finamePickle]);
cent = tmp_load.cnm_pickle.coms;

%% load tif max image
t = Tiff('C:\Users\Kyungsoo Kim\\Box\Transplant_Data\Blood Flow\M98\M98_bf_edited.tif','r'); %m98
% t = Tiff('C:\Users\Kyungsoo Kim\Box\Transplant_Data\Blood Flow\max projection\M150_bf.tiff','r');
ca_max = read(t);
ca_max = squeeze(mean(ca_max,3));
v_max = max(ca_max,[],'all');
ca_max = ca_max/v_max;
figure
imagesc(ca_max)

v_fil = 3;
filt1 = ones(v_fil,v_fil)/v_fil^2;
thres = 0.6; % 0.455 for m98 0.67 for m017 m118 0.78
conv_ca_max = conv2(ca_max,filt1);
conv_ca_max(find(conv_ca_max < thres)) = 0;
conv_ca_max(find(conv_ca_max >= thres)) = 1;
figure
imagesc(conv_ca_max)

% plot cell centroid over maxP
figure
imagesc(ca_max)
colormap('gray')
hold on
scatter(cent(:,2),cent(:,1),'r','filled')

%% get coord from max projection
[maxPC(:,1), maxPC(:,2), dataValues] = find(conv_ca_max > 0);

for i = 1:size(cent,1)
    tmp_min_dist = sqrt(sum(size(ca_max).^2));
    for j = 1:size(maxPC,1)
        tmp_min_dist = min(tmp_min_dist, sqrt(sum((cent(i,:) - maxPC(j,:)).^2)));
    end
    cent_min_dist(i) = tmp_min_dist;
end

% cent dist pixel to um
cent_min_dist = cent_min_dist*um_avr;

% cell dist histogram
figure
cent_min_dist_hist = histogram(cent_min_dist, 20,'Normalization','pdf');
xlabel('distance(um)')
ylabel('pdf')
set(gcf,'color','w');
