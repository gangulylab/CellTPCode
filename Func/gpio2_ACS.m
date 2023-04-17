function GPIO_inf = gpio2_ACS(pfile,type_str)
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
    
    %square waveform by thresholding
    GPIO1_th = GPIO1;
    GPIO1_th(find(GPIO1(:,2)<max(GPIO1(:,2))*0.5),2) = 0;
    GPIO1_th(find(GPIO1(:,2)>=max(GPIO1(:,2))*0.5),2) = max(GPIO1(:,2));
    
    %diff of square wave
    GPIO_diff = diff(GPIO1_th(:,2));
    r_time = GPIO1(find(GPIO_diff>max(GPIO_diff)*0.8)+1,1);
    f_time = GPIO1(find(GPIO_diff<min(GPIO_diff)*0.8)+1,1);
    t_dur = f_time-r_time;

       
    % to return
    GPIO_inf.r_time = r_time;
    GPIO_inf.f_time = f_time;

end


