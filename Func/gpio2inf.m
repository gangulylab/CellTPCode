function GPIO_inf = gpio2inf(pfile,type_str, pulse_train)
% to get video start information from GPIO
% file for GPIO file '.csv'
% type_str for the variable name in the GPIO file for example 'GPIO-1'
% pulse_train will be removed soon since no more pulse train used
    
    
%     pfile = [fpath GPIO_file];
%     type_str = 'GPIO-1';
    GPIOload = readtable(pfile);

    %% extract GPIO1 (trigger signal) from CSV file
    temp_lb = find(strcmp(GPIOload{:, 2}, type_str));
    GPIO1 = [table2array(GPIOload(temp_lb,1)) table2array(GPIOload(temp_lb,3))];
    %low to high
    % GPIO1(:,2) = abs(GPIO1(:,2)-repmat(max(GPIO1(:,2)),size(GPIO1,1),1));

    if pulse_train == 1
        max_dist = 40;
        min_dist = 0.1;
        min_dist1 = 0.15;
        n_mov = 20;
        min_t = 10;
        %flatting
        GPIO_a = zeros(size(GPIO1,1),1);
        GPIO_a(find(GPIO1(:,2) > max(GPIO1(:,2))*0.8)) = max(GPIO1(:,2));
        
        GPIO1_deriv = diff(GPIO_a);
        [GPIO1_mpeak,GPIO1_mlocs] = findpeaks(GPIO1_deriv, 'MinPeakHeight', max(GPIO1_deriv)/3);
        [GPIO1_mpeak,GPIO1_mlocs(:,2)] = findpeaks(-GPIO1_deriv, 'MinPeakHeight', max(GPIO1_deriv)/3);
        GPIO1_locs = sort(GPIO1_mlocs(:))+1;
        GPIO1_locs_diff = diff(GPIO1(GPIO1_locs,1));
        

        rej = find(GPIO1_locs_diff <= min_dist);
        rej(:,2) = rej+1;
        rej = sort(rej(:));
        rej(find(diff(rej) ==0)) = [];
        GPIO1_locs(rej) = [];
%         rej = find(GPIO1_locs_diff >= max_dist);
%         GPIO_inf.touch = GPIO1(GPIO1_locs+1,1);
        

%         GPIO_inf.touch(rej) =[];
        GPIO_locs_deri = transpose(reshape(GPIO1_locs,2,ceil(size(GPIO1_locs,1)/2)));
        locs_deri_diff = GPIO1(GPIO_locs_deri(:,2),1)-GPIO1(GPIO_locs_deri(:,1),1);
        GPIO_locs_deri(find(locs_deri_diff > min_dist1),:) = [];
        c_locs = GPIO_locs_deri(:,1);
        
        GPIO_inf.touch = GPIO1(c_locs,1);
        
        if GPIO_inf.touch(1) <= min_t
            GPIO_inf.touch(1) = [];
        end
        
        figure
        plot(GPIO1(:,1),GPIO1(:,2));
        hold on
        plot(GPIO1(:,1),GPIO_a,'k')
        plot(GPIO1(GPIO1_locs(:,1),1),max(GPIO1(:,2)),'g.')
        plot(GPIO_inf.touch,max(GPIO1(:,2)),'r.')
        

                figure
        plot(GPIO1(:,2));
        hold on
        plot(GPIO1_locs(:,1),max(GPIO1(:,2)),'g.')
        plot(GPIO_inf.touch,max(GPIO1(:,2)),'r.')
        
        GPIO_locs_deri = transpose(reshape(GPIO1_locs,2,ceil(size(GPIO1_locs,1)/2)));
        plot(GPIO1(GPIO_locs_deri(:,1),1),max(GPIO1(:,2)),'g.')
        plot(GPIO1(GPIO_locs_deri(:,2),1),max(GPIO1(:,2)),'r.')
        
    else
        max_dist = 40;
        min_dist = 0.1;
        min_dist1 = 0.15;
        s_bin = 0.8;
        n_mov = 20;
        min_t = 10;
        %flatting
        GPIO_a = zeros(size(GPIO1,1),1);
        GPIO_a(find(GPIO1(:,2) > max(GPIO1(:,2))*0.8)) = max(GPIO1(:,2));
        
        GPIO1_deriv = diff(GPIO_a);
        [GPIO1_mpeak,GPIO1_mlocs] = findpeaks(GPIO1_deriv, 'MinPeakHeight', max(GPIO1_deriv)/3);
        [GPIO1_mpeak,GPIO1_mlocs(:,2)] = findpeaks(-GPIO1_deriv, 'MinPeakHeight', max(GPIO1_deriv)/3);
        GPIO1_locs = sort(GPIO1_mlocs(:))+1;
        
        k = 1;
        i = 1;
        GPIO_pt = [];
        GPIO_st = [];
        GPIO_end = [];
        while i <= size(GPIO1_locs,1)
            tmp_bin = length(find(GPIO1(GPIO1_locs,1) >= GPIO1(GPIO1_locs(i),1) & GPIO1(GPIO1_locs,1) < GPIO1(GPIO1_locs(i),1)+s_bin));
            
            
            GPIO_bin(k) = tmp_bin;
            if i >= size(GPIO1_locs,1)
                break
            end
            
            switch tmp_bin
                case 2
                    GPIO_pt = [GPIO_pt GPIO1_locs(i)];
                case 4
                    GPIO_st = [GPIO_st GPIO1_locs(i)];
                case 8
                    GPIO_end = [GPIO_end GPIO1_locs(i)];
            end
            
            k = k+1;
            i = i+tmp_bin;
        end
        
        GPIO_inf.touch = GPIO1(GPIO_pt,1);
        GPIO_inf.start = GPIO1(GPIO_st,1);
        GPIO_inf.end = GPIO1(GPIO_end,1);
        
        if GPIO_inf.touch(1) <= min_t
            GPIO_inf.touch(1) = [];
        end
        
        figure
        plot(GPIO1(:,1),GPIO1(:,2));
        hold on
        plot(GPIO1(:,1),GPIO_a,'k')
        try
        plot(GPIO_inf.touch,max(GPIO1(:,2)),'r.')
        end
        try
        plot(GPIO_inf.start,max(GPIO1(:,2)),'g.')
        end
        try
        plot(GPIO_inf.end,max(GPIO1(:,2)),'y.')
        end
        

                
    end


end


