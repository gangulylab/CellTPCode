function events_load = event_lo(pfile);
%event load in matrix with labels
%output = event_time, cell label, amplitude
    events = readtable(pfile);  % events
    events_load = readmatrix(pfile);
    event_label = events{:,2};
    event_label = split(event_label,'C');
    event_label(:,1) = [];
    event_label = str2double(event_label);
    events_load(:,2) = event_label;
end