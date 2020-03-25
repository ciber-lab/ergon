function cm = CM(data,names)

% cm = Confusion Matrix
[cm, order] = confusionmat(data(:,1),data(:,2));

for i = 1:size(cm,1)
    cm(i,:) = cm(i,:)/sum(cm(i,:));
end

% Generate Table
if nargin == 2
    cm = array2table(cm,'VariableNames',names,'RowNames',names);
end