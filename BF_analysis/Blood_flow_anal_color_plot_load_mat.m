%% blood flow speed analysis manual
clear all
close all
%% parameters
% lo_sepa = 10;  % data load section division level
fs = 60;
lo_t = [20 23]; %time from to in the data
ts = 1/fs;
pix2um = 950/1280;
sq_size = 6;
it_cplot = 3;   % number of averages
%% data load
[fname,fpath]=uigetfile('*.tiff','Select Tiff File');
tiff_loname = [fpath '\' fname];
tiff_info = imfinfo(tiff_loname);
tiff_length = length(tiff_info);
clear tiff_info

h = waitbar(0,'loading images');
for z = lo_t(1)*fs:lo_t(2)*fs
  tiff_data(:,:,z) = imread(tiff_loname, z);
  waitbar(z-lo_t(1)*fs+1/(lo_t(2)-lo_t(1))*fs);
end
close(h)
t = 0:1/fs:size(tiff_data,3)/fs-1/fs;
%% max(mean) projection
% ca_max = max(tiff_data,[],3);
% ca_mean = -mean(tiff_data,3);
% ca_max = max(abs(tiff_data),[],3);
% max(ca_max,[],'all')
% figure
% imagesc(ca_mean);
% figure
% imagesc(ca_max);
% filt1 = ones(10,10);
% conv_ca_mean = conv2(ca_mean,filt1);
% figure
% imagesc(conv_ca_mean);
% 
% conv_ca_max = conv2(ca_max,filt1);
% figure
% imagesc(conv_ca_max);
% %%% upto here run first and set max_th
% 
% % max_th = mean(mean(ca_max(1:100,1:100)));
% max_th = 0.6;   % threshold
% ca_max_fil = conv_ca_mean;
% ca_max_fil(find(ca_max_fil < max_th)) = 0;   %0.25for std
% figure
% imagesc(ca_max_fil)
% ca_max_fil(find(ca_max_fil >= max_th)) = 1;
% figure
% imagesc(ca_max_fil)


t = Tiff('C:\Users\chopa\Box\Transplant_Data\Blood Flow\M98\M98_bf_edited.tif','r');
ca_max = read(t);
ca_max = squeeze(mean(ca_max,3));
figure
imagesc(ca_max)
colormap('gray')
v_fil = 3;
filt1 = ones(v_fil,v_fil)/v_fil^2;
conv_ca_mean = conv2(ca_max,filt1);
thres = 0.455;
v_max = max(ca_max,[],'all');
conv_ca_max = conv2(ca_max,filt1);
conv_ca_max(find(conv_ca_max < thres*v_max)) = 0;

figure
imagesc(conv_ca_max)
ca_max_fil = conv_ca_max;
ca_max_fil(find(ca_max_fil > 0)) = 1;

figure
imagesc(ca_max_fil)

for q = 1:it_cplot
    % ca_max_update make and remove out bound
    ca_max_update = ca_max_fil;
    out_bound = zeros(size(ca_max_fil));
    out_bound(sq_size+1:size(out_bound,1)-sq_size-1,sq_size+1:size(out_bound,2)-sq_size-1) =1;
    ca_max_update = ca_max_update & out_bound;
    flow_complete = zeros(size(ca_max_fil));
    flow_speed_map = zeros(size(ca_max_fil));
    %% random agent in the mask data
    h = waitbar(0,'blood speed calcuation');
    while sum(sum(ca_max_update))>0
        [n_p_agent_y n_p_agent_x] = find(ca_max_update== 1);
        rd_n = randperm(length(n_p_agent_x),1);
        %bound square
        agent_sq_space = zeros(size(ca_max_fil));
        agent_y= n_p_agent_y(rd_n);
        agent_x= n_p_agent_x(rd_n);
    %     try
            agent_sq_space(agent_y-sq_size:agent_y+sq_size,agent_x-sq_size:agent_x+sq_size) = 1;

        %overlap with ca_max_update
        agent_ovlap = ca_max_update & agent_sq_space;
        [y_update x_update]= find(agent_ovlap == 1);
        tmp_corr_data = [];
        bf_speed = [];
        bf_tau = [];
        bf_dist = [];
        %get cordinate and signal
        for i = 1:length(x_update)
            try
            tmp_corr_data(i,:) = reshape(tiff_data(y_update(i),x_update(i),:),1,size(tiff_data,3));
            end
        end

        %calculate xcorr
        for i = 1:size(tmp_corr_data,1)
            for j = 1:size(tmp_corr_data,1)
                xcorr_tmp = xcorr(tmp_corr_data(j,:),tmp_corr_data(i,:));
                tmp_max_corr = find(xcorr_tmp == max(xcorr_tmp));
                bf_tau(i,j) = tmp_max_corr(1)-size(tmp_corr_data,2);
                bf_dist(i,j) = sqrt((y_update(i)-y_update(1))^2+(x_update(i)-x_update(1))^2);
                if bf_tau(i,j) ~= 0
                    bf_speed(i,j) = (bf_dist(i,j)*pix2um)/(abs(bf_tau(i,j))*ts);
                else
                    bf_speed(i,j) = 0;
                end
            end
        end
        for i = 1:length(x_update)
            flow_speed_map(y_update(i),x_update(i)) = max(max(bf_speed));
        end
    %     catch
    %         agent_sq_space(agent_y:agent_y,agent_x:agent_x) = 1;
    %         y_update = agent_y;
    %         y_update = agent_x;
    %     end
        flow_complete(y_update,x_update) = 1;
        ca_max_update(y_update,x_update) = 0;

        figure(100+q)
        imagesc(flow_speed_map)
        waitbar(1-sum(sum(ca_max_update))/sum(sum(ca_max_fil)));
    end
    close(h)
    flow_speed_map_all(q,:,:) = flow_speed_map;
end

flow_speed_map_mean = squeeze(mean(flow_speed_map_all,1));
figure
imagesc(flow_speed_map_mean)