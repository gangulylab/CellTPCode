function out = cirs_resh(tmp_data,k)
    
    for c = 1:size(tmp_data,2)
        if k > 0
            tmp_data_tr_t = circshift(squeeze(tmp_data(:,c,:)), round(randi(k*2)-k),2);
        else
            tmp_data_tr_t = squeeze(tmp_data(:,c,:));
        end
        out(:,c) = reshape(tmp_data_tr_t', 1,[])';
    end
    




end