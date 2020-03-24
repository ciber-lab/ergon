function selecteddata = selectdata(data, timefrom, timeto)
%% Selecting certain Range of data
% clean out data by selecting only the values at
% timefrom <= time <= timeto
for from = 1:size(data,1)
    if (data(from,1)> timefrom)
        break;
    end
end
to = from;
for to = 1:size(data,1)
    if (data(to,1)> timeto)
        break;
    end
end
to = to - 1;
selecteddata = data (from:to,:);
end