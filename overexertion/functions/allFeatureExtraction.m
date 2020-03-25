function [FE_data, classLabels, classFreq] = allFeatureExtraction ( data, windowSize, ifAnnotation )
    %% Feature Extraction from Annoted TimeUniform data
    % inputX      = numerical matrix, 
    %              columns are sensor readings, *** 1st column TimeStamps ***
    %              rows are observations.
    % windowSize  = size of window in number of data points
    % inputY      = numerical class labels, 
    % FE_data     = Extracted Features,
    % classLabels = Most frequent class in each window
    % classFreq   = frquency of the most frequent class in each window
%%
    if nargin == 2
        ifAnnotation = 0;
    end
    
    % Separating Annoted Class Labels
    if ifAnnotation == 1
        class = data(:,end);
        data(:,end) = [];
    end
    
    % Removing Timestamps
    data(:,1) = [];
 %% 
    disp('Extracting Features...');
    st = cputime;
    
    num_windows = floor(2*size(data,1)/windowSize-1);
    FE_data = zeros(num_windows,size(data,2)*12);
    classLabels = zeros(num_windows,1);
    classFreq = zeros(num_windows,1);

    for i = 1:num_windows
        si = 1 + (i-1)*windowSize/2;
        ei = si + windowSize - 1;

        %Feature Extraction % number of statistical features = 12
        ar = arburg(data(si:ei,:),4);        
        FE_data(i,:) = [mean(data(si:ei,:)),...
                        max(data(si:ei,:)),...
                        min(data(si:ei,:)),...
                        iqr(data(si:ei,:)),...
                        std(data(si:ei,:)),...
                        skewness(data(si:ei,:)),...
                        kurtosis(data(si:ei,:)),...
                        mad(data(si:ei,:),1),...
                        ar(:,2)',ar(:,3)',ar(:,4)',ar(:,5)'];
        
        % class labels
        if ifAnnotation == 1
            [label,frq] = mode ((class((si:ei),1)));
            classLabels(i,:) = label;
            classFreq(i,:) = frq;
        end
    end
    
    disp(['--- time taken: ',num2str(cputime-st),' sec']);
end
