function [VarNames, PP_VarNames, triAxialDataIndices] = genVarNames(sensors, positions)
% *** triAxial sensors must contain '_XYZ' ***

% Find TriaAxial and UniAxial Sensors Indices
triAxialSensorIndices = false(1, size(sensors,2));
for i = 1:numel(sensors)
    k = strfind(sensors{i},'_XYZ');
    if numel(k) ~= 0
        triAxialSensorIndices(1,i) = true ;
    end
end
triAxial_sensors = sensors(1,triAxialSensorIndices);
triAxial_sensors = strrep(triAxial_sensors,'_XYZ','');
uniAxial_sensors = sensors(1,~triAxialSensorIndices);


triAxialDataIndices = false(1, 1 + 3*numel(triAxial_sensors) + numel(uniAxial_sensors));
i = 2; j = 1;
while i <= numel(triAxialDataIndices)
    if triAxialSensorIndices(j)
        triAxialDataIndices(1,i:i+2) = true ;
        i = i + 3;
    else
    i = i+1;
    end
    j = j + 1;
end

% VarNames for FE Data
AxesNames = {'X', 'Y', 'Z'};
AxesNames =strcat('_',AxesNames );
[ii,jj] = ndgrid(1:numel(AxesNames),1:numel(triAxial_sensors));
triAxial_sensors_XYZ = (arrayfun(@(x,y) strcat(triAxial_sensors(x), AxesNames(y)),jj(:),ii(:)))';

% VarNames for preProcess Data
PP_VarNames = [{'Time'},triAxial_sensors_XYZ,uniAxial_sensors,...
               strcat(triAxial_sensors_XYZ,'_Jerk'),...
               strcat(uniAxial_sensors,'_Jerk'),...
               strcat(triAxial_sensors,'_Mag'),...
               strcat(triAxial_sensors,'_Jerk_Mag')];
           
% VarNames for FE Data
featureNames = {'Mean', 'Max', 'Min', 'IQR', 'SD', 'Skewness','Kurtosis','MAD','ARcoeff1','ARcoeff2','ARcoeff3','ARcoeff4'};
featureNames =strcat('_',featureNames );
[ii,jj] = ndgrid(2:numel(PP_VarNames),1:numel(featureNames));
FE_VarNames = (arrayfun(@(x,y) strcat(PP_VarNames(y), featureNames(x)),jj(:),ii(:)))';

if nargin == 1
    VarNames = FE_VarNames;
    return;
end

% VarNames for FE Data for All position
positions =strcat(positions,'_');
[ii,jj] = ndgrid(1:numel(FE_VarNames),1:numel(positions));
VarNames = (arrayfun(@(x,y) strcat(positions(x), FE_VarNames(y)),jj(:),ii(:)))';
