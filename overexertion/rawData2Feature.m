% do not delete existing variables:
extVarNames = who;
st = cputime;
%% INPUT

sensors = {'Acc_XYZ', 'LinAcc_XYZ', 'Gyro_XYZ'};
position = {'Arm','Waist'};
prefix1 = 'C1';
prefix2 = 'W';

samplingRate = 180;
windowSize = 360;

%% LOAD
addpath([pwd,'\matlab-data']);
addpath([pwd,'\functions']);

load(['VideoAnn_',prefix1,'.mat'])
load([prefix1,'_RawData.mat'])

%% Auto assign data
eval(['videoAnn = VideoAnn_',prefix1,prefix2,'; data1 = ',prefix1,prefix2,'a; data2 = ',prefix1,prefix2,'w;']);
if prefix2 == 'W'
    eval(['sensorStartOffset1 = sensorStartOffset_',prefix1,'(1);']);
    eval(['sensorStartOffset2 = sensorStartOffset_',prefix1,'(2);']);
else
    eval(['sensorStartOffset1 = sensorStartOffset_',prefix1,'(3);']);
    eval(['sensorStartOffset2 = sensorStartOffset_',prefix1,'(4);']);
end
%% OUTPUT

[VarNames,~,tAi] = genVarNames (sensors,position);

TU1 = timeUniform(data1,samplingRate);
nTU1 = annotationFromVideo(TU1,videoAnn,sensorStartOffset1);
PP1 = preProcess(nTU1,tAi,1);
[FE1,Ann1] = allFeatureExtraction(PP1,windowSize,1);

TU2 = timeUniform(data2,samplingRate);
nTU2 = annotationFromVideo(TU2,videoAnn,sensorStartOffset2);
PP2 = preProcess(nTU2,tAi,1);
[FE2,Ann2] = allFeatureExtraction(PP2,windowSize,1);

FE = [FE1,FE2];
if (sum(Ann1 == Ann2)==numel(Ann1))
    Ann = Ann1;
end

% Autogenerate variable names
FE_name = [prefix1,prefix2,'_FE'];
Ann_name = [prefix1,prefix2,'_Ann'];
eval([FE_name,'=FE;']);
eval([Ann_name,'=Ann;']);

disp(cputime-st);

%% CLEAR workspace
clearvarlist = ['clearvarlist';setdiff(who,[extVarNames',{FE_name,Ann_name,'VarNames'}])];
clear(clearvarlist{:});