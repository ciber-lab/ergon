%% INPUT

phone_position = 'arm';
sr = 100;   % int, sampling rate
ws = 200;   % int, window size in data points

%% READ CSV FILES

fn = 16;    % integer, no of total postures

RawData{fn} =[];

for i = 1 : fn
   % filename
   if i <= 6
       % read dataset-1
       filename = ['dataset-1/', phone_position, '/p', int2str(i), '.csv'];
   else
       % read dataset-2
       filename = ['dataset-2/', phone_position, '/p', int2str(i), '.csv'];
   end
   % read csv file
   RawData{i} = csvread(filename, 2, 0);
end

clear filename i;

%% DATA CLEANING

% select certain range of data
% [file (int), time from (double), time to(double), ...]
range = [1,1,11, 2,1,14, 3,6,16, 4,2,14, 5,5,16, 6,1,14];

SRdata = RawData;

i = 1;
while (i < numel(range))
   % select data
   SRdata{range(i)} = selectdata(RawData{1,range(i)},range(i+1),range(i+2));
   i = i+3;
end

clear range i;

%% DATA PRE-PROCESSING

TUdata{fn} =[];
FEdata{fn} =[];

for i = 1 : fn
    % uniform the timespaces
    TUdata{i} = timeUniform(SRdata{1,i}(:,1:4),sr);
    % extract features
    FEdata{i} = featureExtraction(TUdata{i},ws);
end

clear sr ws i fn;

%% SUMMARY

summary =[];

for i = 1 : 16
    for j = 2 : 10
        % take mean of the extracted features over all windows
        summary(j-1,i) = mean(FEdata{1, i}(:,j));
    end
end

clear i j;

%% SAVE

save(['data_', phone_position, '.mat']);

clear phone_position;