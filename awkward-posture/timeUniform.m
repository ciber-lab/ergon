function result = timeUniform ( data, sampleRate )
    %1st timestamp
    for l = 1 : size(data,2)
        result (1,l) = data (1,l);
    end
    
    % next stamps with uniform interval
    k = 2;
    i = 2;
    while (result(i-1,1)+1/sampleRate < data(end,1))
        % timestamps
        result (i,1) = result (i-1,1) + (1/sampleRate);
        % find next
        for j = k : size(data,1)
            if ( data(j,1) - result(i,1) >= (1/sampleRate) )
                k = j;
                break;
            end
        end
        % interpolate
        for l = 2 : size(data,2)
            result (i,l) = result (i-1,l) + (1/sampleRate)/(data(k,1) - result(i-1,1))*(data (k,l)- result(i-1,l));
        end
        i = i+1;
    end
    
%     result(1,1) = 0;
%     for l = 2 : size(result,1)
%         result (l,1) = result (l-1,1) + (1/sampleRate);
%     end
end