function PPdata = preProcess ( data, triAxialDataIndices, ifAnnotation )
% INPUT
% data = numeric matrix of timeStamps and sensors' data
% triAxialDataIndices = indices of triAxial sensors' data 
%                       (i.e. Acc- X Y Z, Linear Acc- X Y Z, Gyro- X Y Z..)
%                       in the data matrix.

disp('Generating jerk and magnitude data...');
st = cputime;
    
if nargin == 2
    ifAnnotation = 0;
elseif nargin == 1
    ifAnnotation = 0;
    triAxialDataIndices = 2:size(data,2);
end
    

% separate the annotation from the data
if ifAnnotation == 1
    ann = data(:,end);
    data(:,end) = [];
else
    ann = [];
end

% Noise removal
% [b,a] = butter(3, 0.8);
% data(:,2:end) = filter(b, a, medfilt1(data(:,2:end)));

% separate the triAxial data
triAxial_data = data(:,triAxialDataIndices);
% calculate jerk
triAxial_jerk_data = diff(triAxial_data);

if size(data(:,2:end),2) ~= size(triAxial_data,2)
    uniAxial_data = data;
    uniAxial_data(:,triAxialDataIndices) = [];
    uniAxial_data(:,1) = []; %Removing TimeStamps
    uniAxial_jerk_data = diff(uniAxial_data);
else
    uniAxial_data = [];
    uniAxial_jerk_data = [];
end



% calculate magnitude of triAxial data
mag_data = zeros(size(triAxial_data,1),size(triAxial_data,2)/3);
jerk_mag_data = zeros(size(triAxial_jerk_data,1),size(triAxial_jerk_data,2)/3);

j = 1;
for i = 1:3:size(triAxial_data,2)
    mag_data(:,j) = sqrt(triAxial_data(:,i).^2 + triAxial_data(:,i+1).^2 + triAxial_data(:,i+2).^2);
    jerk_mag_data(:,j) = sqrt(triAxial_jerk_data(:,i).^2 + triAxial_jerk_data(:,i+1).^2 + triAxial_jerk_data(:,i+2).^2);
    j = j + 1;
end

% combine the results
PPdata = [data(1:end-1,1)...
          triAxial_data(1:end-1,:), uniAxial_data(1:end-1,:),...
          triAxial_jerk_data, uniAxial_jerk_data,...
          mag_data(1:end-1,:), jerk_mag_data,...
          ann(1:end-1,:)];
      
disp(['--- time taken: ',num2str(cputime-st),' sec']);
end