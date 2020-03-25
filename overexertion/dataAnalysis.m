% do not delete existing variables:
extVarNames = who;

%% INPUT

% feature selection
num_feat_W =125;
num_feat_I = 84;

% exporting to excel
fileName = 'Result_Analysis_2020.xlsx';

% input for duration extraction
windowSizeInSec = 2;
windowOverlap = 0.5;
outlierThresholdW = 1;
outlierThresholdI = 1;
annNamesW = {'Wait','Load','Unload','Lower','Push','Pull'};
annNamesI = {'Wait','Lift','Inspect','Reject'};

%% Preparation

addpath([pwd,'\matlab-data']);
addpath([pwd,'\functions']);
addpath([pwd,'\utils']);

load('FEdata360.mat');

copyfile('utils\Result_Analysis_Template.xlsx',fileName)

%% ANALYSES

% feature selection
RW = RW(1:num_feat_W);
RI = RI(1:num_feat_I);

for testRun = 1:5
% Auto generate some data
switch testRun
    case 1
        trainXW = C1W_FE(1:800,:); trainYW = C1W_Ann(1:800,:);
        testXW = C1W_FE(801:end,:); testYW = C1W_Ann(801:end,:);
        trainXI = C1I_FE(1:800,:); trainYI = C1I_Ann(1:800,:);
        testXI = C1I_FE(801:end,:); testYI = C1I_Ann(801:end,:);
    case 2
        trainXW = C2W_FE(1:900,:); trainYW = C2W_Ann(1:900,:);
        testXW = C2W_FE(901:end,:); testYW = C2W_Ann(901:end,:);
        trainXI = C2I_FE(1:900,:); trainYI = C2I_Ann(1:900,:);
        testXI = C2I_FE(901:end,:); testYI = C2I_Ann(901:end,:);
    case 3
        trainXW = C1W_FE; trainYW = C1W_Ann;
        testXW = C2W_FE; testYW = C2W_Ann;
        trainXI = C1I_FE; trainYI = C1I_Ann;
        testXI = C2I_FE; testYI = C2I_Ann;
    case 4
        trainXW = C2W_FE; trainYW = C2W_Ann;
        testXW = C1W_FE; testYW = C1W_Ann;
        trainXI = C2I_FE; trainYI = C2I_Ann;
        testXI = C1I_FE; testYI = C1I_Ann;
    case 5
        trainXW = [C1W_FE(1:800,:);C2W_FE(1:900,:)]; 
        trainYW = [C1W_Ann(1:800,:);C2W_Ann(1:900,:)]; 
        testXW = [C1W_FE(801:end,:);C2W_FE(901:end,:)]; 
        testYW = [C1W_Ann(801:end,:);C2W_Ann(901:end,:)];
        trainXI = [C1I_FE(1:800,:);C2I_FE(1:900,:)]; 
        trainYI = [C1I_Ann(1:800,:);C2I_Ann(1:900,:)]; 
        testXI = [C1I_FE(801:end,:);C2I_FE(901:end,:)]; 
        testYI = [C1I_Ann(801:end,:);C2I_Ann(901:end,:)];
    otherwise
        disp('other value')
end

%% Classification

extVarNames1 = who;

[resultW, cmW, tmW, durW, act_tmW, act_durW] = classification(trainXW,trainYW,testXW,testYW,RW,VarNames,annNamesW,windowSizeInSec,windowOverlap,outlierThresholdW);
[resultI, cmI, tmI, durI, act_tmI, act_durI] = classification(trainXI,trainYI,testXI,testYI,RI,VarNames,annNamesI,windowSizeInSec,windowOverlap,outlierThresholdI);

%% Export to Excel

A = sum(table2array(resultW(:,2))==table2array(resultW(:,3)))/size(resultW,1);
xlswrite(fileName,A,testRun,'C4');
writetable(resultW,fileName,'Sheet',testRun,'Range','A8');
writetable(cmW,fileName,'Sheet',testRun,'Range','K3');
writetable(tmW,fileName,'Sheet',testRun,'Range','K11');
writetable(act_tmW,fileName,'Sheet',testRun,'Range','K19');
writetable(durW,fileName,'Sheet',testRun,'Range','T3');
writetable(act_durW,fileName,'Sheet',testRun,'Range','R3');

A = sum(table2array(resultI(:,2))==table2array(resultI(:,3)))/size(resultI,1);
xlswrite(fileName,A,testRun,'G4');
writetable(resultI,fileName,'Sheet',testRun,'Range','E8');
writetable(cmI,fileName,'Sheet',testRun,'Range','L29');
writetable(tmI,fileName,'Sheet',testRun,'Range','L35');
writetable(act_tmI,fileName,'Sheet',testRun,'Range','L41');
writetable(durI,fileName,'Sheet',testRun,'Range','Z3');
writetable(act_durI,fileName,'Sheet',testRun,'Range','X3');

disp(['test run ',num2str(testRun),' is successful...'])
end

%% CLEAR workspace

clearvarlist = ['clearvarlist';setdiff([extVarNames1;'extVarNames1'],extVarNames)];
clear(clearvarlist{:});