function tm = TM(data,names)

% tm = Tranistion Matrix
[tm, order] = confusionmat(data(1:end-1,1),data(2:end,1));
%transitions to itself set to zero
for i = 1:size(tm,1)
    tm(i,i) = 0;
end

% for i = 1:size(tm,1)
%     tm(i,:) = tm(i,:)/sum(tm(i,:));
% end
% Generate Table   
if nargin ~= 2 || numel(order) ~= numel(names)
    names = strcat('Var',cellstr(num2str(order)));
end
tm = array2table(tm,'VariableNames',names,'RowNames',names);