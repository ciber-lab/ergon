function TUdata = timeUniform( data, samplingRate )
    disp('Resampling data to uniform time intervals...');
    st = cputime;
    
    if nargin == 1
    	samplingRate = 10*ceil(size(data,1)/(10*data(end,1)));
        disp(['Choosen Sampling Rate of: ',num2str(samplingRate),' Hz']);
    end
    
    % Removing repititive data
    [~, ia, ~] = unique(data(:,1),'rows');
    temp_T = data(ia,:);
    % Resampled uniform time series
    uniTime = (temp_T(1,1):(1/samplingRate):temp_T(end,1))';
    % Linear interpolation
    TUdata = [uniTime,interp1(temp_T(:,1),temp_T(:,2:end),uniTime,'linear')];
    
    
    disp(['--- time taken: ',num2str(cputime-st),' sec']);
end