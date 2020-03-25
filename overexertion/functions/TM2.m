function [tm,act_tm] = TM2(data,act_data,names)

% tm = Tranistion Matrix
[act_tm, order] = confusionmat(act_data(1:end-1,1),act_data(2:end,1));

u = unique(act_data);
tm = confusionmat([data(1:end-1,1);u],[data(2:end,1);u]);

%transitions to itself set to zero
for i = 1:size(tm,1)
    tm(i,i) = 0;
    act_tm(i,i) = 0;
end

for i = 1:size(tm,1)
    tm(i,:) = tm(i,:)/sum(tm(i,:));
    act_tm(i,:) = act_tm(i,:)/sum(act_tm(i,:));
end
% Generate Table   
if nargin ~= 3 %|| numel(order) ~= numel(names)
    names = strcat('Var',cellstr(num2str(order)));
end
tm = array2table(tm,'VariableNames',names,'RowNames',names);
act_tm = array2table(act_tm,'VariableNames',names,'RowNames',names);