function result = featureExtraction ( data, windowSize )
    %% Feature Extraction
    % data       = numerical matrix, 
    %              1st column should be timestamps,
    %              rest of the columns are different attributes/features
    % windowSize = size of window in number of data points
    % result     = numerical matrix, 
    %              1st column is timestamps,
    %              rest of the columns are extracted attributes/features
    %%
    si = 1;
    ei = si + windowSize - 1;
    n = 1;
    %%
    while ( ei < size(data,1) )
        result(n,1) = n;
        k = 2;
        for m = 2: size(data,2)
            result (n,k) = mean (data((si:ei),m));
            k = k + 1;
            result (n,k) = max (data((si:ei),m));
            k = k + 1;
            result (n,k) = min (data((si:ei),m));
            k = k + 1;
%             result (n,k) = iqr ((data((si:ei),m)));
%             k = k + 1;
        end     
        n = n + 1;
        si = si + windowSize/2;
        ei = si + windowSize - 1;
    end
end
