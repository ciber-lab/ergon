function result = outlierRemoval(data, chunk)

if nargin < 2
    chunk = 1;
end
check = zeros(size(data,1),1);
for i = 1+chunk: size(data,1)-chunk
    match = 1;
    if ~cellfun(@strcmp,data(i-1,1),data(i+1,1))
        match = 0;
        check(i) = 1;
    else
        if chunk > 1
        for j = i-chunk:i-2
            if ~cellfun(@strcmp,data(j,1),data(j+1,1))
                match = 0;
                check(i) = 2;
            end
        end
        for j = i+1:i+chunk-1
            if ~cellfun(@strcmp,data(j,1),data(j+1,1))
                match = 0;
                check(i) = 3;
            end
        end
        end
    end
    
    if match == 1
        data(i,1) = data(i+1,1);
    end
    result = data;
end

    