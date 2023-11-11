function out = plt_traj(tmp_score,pt_time,k)
%     plot(tmp_score(:,1),tmp_score(:,2))
%     tmp_score = movmean(tmp_score,4);
    try
        for i = 1:2
            gprMdl = fitrgp([1:size(tmp_score,1)]',tmp_score(:,i),'Basis','linear',...
          'FitMethod','exact','PredictMethod','exact');

        tmp_score(:,i) = resubPredict(gprMdl);
        end
        plot(tmp_score(:,1)-tmp_score(1,1),tmp_score(:,2)-tmp_score(1,2), 'Color', [0.15*k 0 0])
        hold on
        scatter(tmp_score(pt_time,1)-tmp_score(1,1),tmp_score(pt_time,2)-tmp_score(1,2),'filled') % dot for pellet touch
        out = 1;
    catch
       out = 0; 
    end
    
end


