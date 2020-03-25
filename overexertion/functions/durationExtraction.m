function result = durationExtraction(data,windowSizeInSec,windowOverlap,threshold)

result = [];
i = 1;
while i < size(data,1)
    for j = i:size(data,1)-1
        if data(j,1) ~= data(j+1,1)
            break;
        end
    end
    result = [result;[data(j,1),j-i+1]];
    i = j+1;
end

result(result(:,2)<=threshold,:)=[];

j = 1;
while j < size(result,1)
        if result(j,1) == result(j+1,1)
            result(j,2) = result(j,2)+result(j+1,2);
            result(j+1,:) = [];
        end
        j = j + 1;
end

result(:,2) = result(:,2)*windowSizeInSec*windowOverlap;