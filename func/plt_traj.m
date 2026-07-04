function out = plt_traj(tmp_score,pt_time,k)
% Plot a 2D neural trajectory (first two PCA scores), GP-smoothing each
% dimension and marking the pellet-touch sample. k shades the line color.
% Returns 1 on success, 0 if smoothing/plotting fails.
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


