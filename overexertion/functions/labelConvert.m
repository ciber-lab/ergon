function result = labelConvert (data, A, B)    
    if isnumeric(data)
        result = cell(size(data,1),size(data,2));
        if iscell(B)
            from = A; to = B;
        else
            from= B; to = A;
        end
        
        for k = 1:size(data,2)
            for i = 1:size(data,1)
                result{i,k} = to{from==data(i,k)};
            end
        end
        
    else
        result = zeros(size(data,1),size(data,2));
        if iscell(A)
            from = A; to = B;
        else
            from= B; to = A;
        end
        for k = 1:size(data,2)
            for i = 1:size(data,1)
                for j = 1:size(from,2)
                    if strcmp(data(i,k),from(1,j))
                            result(i,k) = to(1,j); break;
                    end
                end
            end
        end
    end
end