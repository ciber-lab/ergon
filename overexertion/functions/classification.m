function [result,cm,tm,durations,actual_tm,actual_durations] = classification(trainX,trainY,testX,testY,R,VarNames,annNames,windowSizeInSec,windowOverlap,outlierThreshold)

%% Classification
% Generate table
trainX = array2table(trainX,'VariableNames',VarNames);
trainY = array2table(cellstr(num2str(trainY)),'VariableNames',{'Annotation'});
testX = array2table(testX,'VariableNames',VarNames);

mdl = trainMCSVM ([trainX,trainY],VarNames(R));
predictY = str2num(cell2mat(outlierRemoval(mdl.predictFcn(testX))));

%% Analysis
cm = CM([testY,predictY],annNames);
durations = durationExtraction(predictY,windowSizeInSec,windowOverlap,outlierThreshold);
[tm,actual_tm] = TM2(durations(:,1),testY,annNames);

actual_durations = durationExtraction(testY,windowSizeInSec,windowOverlap,outlierThreshold);
% actual_tm = TM(actual_durations(:,1),annNames);
%% Result Table

result = table(labelConvert(testY,unique(testY),annNames),testY,predictY,labelConvert(predictY,unique(predictY),annNames),...
         'VariableNames',{'Actual','actual','predicted','Predicted'});
durations = table(labelConvert(durations(:,1),unique(testY),annNames),durations(:,2),...
         'VariableNames',{'Predicted','Durations'});
actual_durations = table(labelConvert(actual_durations(:,1),unique(testY),annNames),actual_durations(:,2),...
         'VariableNames',{'Actual','Durations'});