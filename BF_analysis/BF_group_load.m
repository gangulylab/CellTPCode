clear all
close all
%% parameters
% lo_sepa = 10;  % data load section division level
fs = 60;
t_cut = [1000 1200];
ts = 1/fs;
pix2um = 950/1280;
sq_size = 15;
it_cplot = 50;   % number of averages
%% load data
% mname = {'M98','M107','M118','M150'};
mname = {'M98','M107','M150'};
% mname = {'M98','M107','M118'};
foname = 'C:\Users\chopa\Box\Transplant_Data\Blood Flow\';


for m = 1:size(mname,2)
    t = Tiff([foname 'max_projection\' mname{m} '_BF_edited.tif'],'r');%load max projection
    ca_max = read(t);
    ca_max = squeeze(mean(ca_max,3))/double(max(ca_max,[],'all'));
    Mbf{m}.maxP = ca_max;
    
    
    
end

% manual thresholding
% m98 0.455   m107 0.35   m118 0.75    m150 0.6
Mbf{1}.thres = 0.455; 
Mbf{2}.thres = 0.35; 
% Mbf{3}.thres = 0.75; 
Mbf{3}.thres = 0.6; 
Mbf{4}.thres = 0.6; 
for m = 1:size(mname,2)
    ca_max = Mbf{m}.maxP;
    % figure
    % imagesc(ca_max)
    % colormap('gray')
    v_fil = 3;
    filt1 = ones(v_fil,v_fil)/v_fil^2;
    conv_ca_mean = conv2(ca_max,filt1);
    % thres = 0.6;
    thres = Mbf{m}.thres;
    conv_ca_max = conv2(ca_max,filt1);
    conv_ca_max(find(conv_ca_max < thres)) = 0;

    % figure
    % imagesc(conv_ca_max)
    ca_max_fil = conv_ca_max;
    ca_max_fil(find(ca_max_fil > 0)) = 1;
    figure
    imagesc(ca_max_fil)
    Mbf{m}.maxP_fil = ca_max_fil;
    load([foname 'save_mat\' mname{m} '.mat']);
    tiff_data = tiff_data(:,:,t_cut(1):t_cut(2));
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
        while sum(sum(ca_max_update))>100
            try
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
            bf_mxcorr = [];
            %get cordinate and signal
            for i = 1:length(y_update)
                try
                    tmp_corr_data(i,:) = reshape(tiff_data(y_update(i),x_update(i),:),1,size(tiff_data,3));
                end
            end

            %calculate xcorr
            rnd_seed_b = randi(length(y_update),1,ceil(sq_size*0.3));
            try
            for i = rnd_seed_b
                    rnd_seed = randi(length(x_update),1,ceil(sq_size*0.3));
                for j = rnd_seed
                    tmp_corr_data_comp = reshape(tiff_data(y_update(i),x_update(i),:),1,size(tiff_data,3));
                    xcorr_tmp = xcorr(tmp_corr_data(i,:),tmp_corr_data(j,:),'normalized');
                    tmp_max_corr = find(abs(xcorr_tmp) == max(abs(xcorr_tmp)));
                    bf_mxcorr(i,j) = max(abs(xcorr_tmp));
                    bf_tau(i,j) = tmp_max_corr(1)-size(tmp_corr_data,2);
                    bf_dist(i,j) = sqrt((y_update(i)-y_update(1))^2+(x_update(i)-x_update(1))^2);
                    if bf_tau(i,j) ~= 0
                        bf_speed(i,j) = (bf_dist(i,j)*pix2um)/(abs(bf_tau(i,j))*ts);
                    else
                        bf_speed(i,j) = 0;
                        bf_mxcorr(i,j) = 0;
                        
                    end
                end
            end
            end
            [tmp_y tmp_x] = find(bf_mxcorr == max(bf_mxcorr,[],'all'));
            tmp_bf_mx = [];
            for i = 1:length(tmp_y)
                    
%                 flow_speed_map(y_update(i),x_update(i)) = max(max(bf_speed));
                
                 tmp_bf_mx(i) = bf_speed(tmp_y(i), tmp_x(i));
            end
            for i = 1:length(y_update)
                flow_speed_map(y_update(i),x_update(i)) = max(tmp_bf_mx);
            end
        %     catch
        %         agent_sq_space(agent_y:agent_y,agent_x:agent_x) = 1;
        %         y_update = agent_y;
        %         y_update = agent_x;
        %     end
            flow_complete(y_update,x_update) = 1;
            ca_max_update(y_update,x_update) = 0;

            figure(100)
            imagesc(flow_speed_map)
            waitbar(1-sum(sum(ca_max_update))/sum(sum(ca_max_fil)));
            catch
                display('error')
            end
        end
        close(h)
        flow_speed_map_all(q,:,:) = flow_speed_map;
    end
    flow_speed_map_mean = squeeze(mean(flow_speed_map_all,1));
    Mbf{m}.flow_speed_map_mean = flow_speed_map_mean;
    figure(10 + m)
    imagesc(flow_speed_map_mean)
    clear flow_speed_map_mean flow_speed_map_all
end

figure
for m = 1:size(mname,2)
    tmp_data = reshape(Mbf{m}.flow_speed_map_mean,1,[]);
    tmp_data(find(tmp_data == 0)) = [];
    
    tmp_hist = histogram(tmp_data,30);
    Mbf{m}.hist_data = tmp_hist.Values;
    Mbf{m}.hist_edge = tmp_hist.BinEdges;
    
    
end

figure
for m = 1:size(mname,2)
    plot(Mbf{m}.hist_edge(1:end-1),Mbf{m}.hist_data/(sum(Mbf{m}.hist_data)));
    hold on
end
xlabel('BF speed (um/s)')
ylabel('Probability density')
set(gcf,'color','w');