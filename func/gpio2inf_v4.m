function GPIO_inf = gpio2inf_v3(pfile,type_str, plot_on)
% to get video start information from GPIO
% file for GPIO file '.csv'
% type_str for the variable name in the GPIO file for example 'GPIO-1'
% pulse_train will be removed soon since no more pulse train used
    t_ref = [0.01 0.03 0.07];
    
%     pfile = [fpath GPIO_file];
%     type_str = 'GPIO-1';
    GPIOload = readtable(pfile);

    %% extract GPIO1 (trigger signal) from CSV file
    temp_lb = find(strcmp(GPIOload{:, 2}, type_str));
    GPIO1 = [table2array(GPIOload(temp_lb,1)) table2array(GPIOload(temp_lb,3))];
    
    %square waveform by thresholding
    GPIO1_th = GPIO1;
    GPIO1_th(find(GPIO1(:,2)<max(GPIO1(:,2))*0.5),2) = 0;
    GPIO1_th(find(GPIO1(:,2)>=max(GPIO1(:,2))*0.5),2) = max(GPIO1(:,2));
    
    %diff of square wave
    GPIO_diff = diff(GPIO1_th(:,2));
    r_time = GPIO1(find(GPIO_diff>max(GPIO_diff)*0.8)+1,1);
    f_time = GPIO1(find(GPIO_diff<min(GPIO_diff)*0.8)+1,1);
    t_dur = f_time-r_time;
    
    cl_t = abs(repmat(t_ref,size(t_dur))-repmat(t_dur,size(t_ref)));
    
    %error clearing
    rej_p = find(min(cl_t,[],2)>0.1);
    cl_t(rej_p,:) = [];
    r_time(rej_p,:) = [];
    f_time(rej_p,:) = [];
    GPIO_pt = [];
    GPIO_st = [];
    GPIO_end = [];
    for i = 1:size(cl_t,1)
        class_dur(i) = find(cl_t(i,:) == min(cl_t(i,:)));
        switch class_dur(i)
            case 1
                GPIO_pt = [GPIO_pt i];
            case 2
                GPIO_st = [GPIO_st i];
            case 3
                GPIO_end = [GPIO_end i];
            otherwise
                disp('error on classification of pulses')
        end
        
    end
    % gpio cleaning for repeated gpio
    
    
    GPIO_pt = cln_gpio(GPIO_pt);
    GPIO_st = cln_gpio(GPIO_st);
    GPIO_end = cln_gpio(GPIO_end);
   
    
    
    
    % to return
    GPIO_inf.touch = r_time(GPIO_pt,1);
    GPIO_inf.start = r_time(GPIO_st,1);
    GPIO_inf.end = r_time(GPIO_end,1);
    
    
    
    
    %plot
    if plot_on == 1

        figure
        plot(GPIO1(:,1),GPIO1(:,2),'k');
        hold on
        plot(GPIO1_th(:,1),GPIO1_th(:,2),'g');
        plot(r_time,max(GPIO1(:,2)),'b.');
        plot(GPIO_inf.touch,max(GPIO1(:,2)),'r.');

        figure
        histogram(t_dur,100);
    end
    


end


