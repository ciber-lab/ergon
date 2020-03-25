function annotedData = annotationFromVideo ( TU_data, videoAnn, sensorStartOffset, videoFPS )
disp('Annotation...');
st = cputime;

if nargin < 4
    videoFPS = 30;
end

samplingRate = 1/(TU_data(2,1) - TU_data(1,1));
% Frame to time to indices
indices = int64(((videoAnn(:,1) - sensorStartOffset)/videoFPS - TU_data(1,1))*samplingRate);
data = TU_data(indices(1,1):indices(end,1)-1,:);

indices = indices - indices(1,1) + 1;
annotations = zeros(indices(end,1)-indices(1,1),1);

for i = 1:size(indices,1)-1
    annotations(indices(i,1):indices(i+1,1)-1,1) = videoAnn(i,2);
end

annotedData = [data,annotations];

disp(['--- time taken: ',num2str(cputime-st),' sec']);