function [selectedFeatures] = JMI_fed_sec(X_data, Y_labels, topK,  T, n_devices)
% Summary 
%    JMI algorithm for feature selection
% Inputs
%    X_data: n x d matrix X, with categorical values for n examples and d features
%    Y_labels: n x 1 vector with the labels
%    topK: Number of features to be selected
%    T: number of fractional bits
%    n_devices: number of devices

if ismember(0, Y_labels)
    Y_labels = Y_labels + 1;
end

% Sequential code - We perform the discretisation process in a single way (does not affect the result)
n_discret = 5;
maxY = max(Y_labels);
equal = disc_dataset_equalwidth(X_data, n_discret);

% IID data sharing
[X_data_fed, Y_labels_fed] = divide_data(equal, Y_labels, n_devices, 123);

numFeatures = size(X_data,2);
numSamples = size(X_data,1);
score_per_feature = zeros(1,numFeatures);

% Calculation of the mutual information for each feature
for index_feature = 1:numFeatures
    score_per_feature(index_feature) = mi_sec_fix_efi_logDiv(X_data_fed(:,index_feature),Y_labels_fed, T, n_devices, n_discret, numSamples, maxY);
end

selectedFeatures = zeros(1,topK);
[val_max,selectedFeatures(1)]= max(score_per_feature);

not_selected_features = setdiff(1:numFeatures,selectedFeatures);

% Calculation of the joint mutual information for each feature
score_per_feature =  zeros(1,numFeatures);
score_per_feature(selectedFeatures(1)) =  NaN;
count = 2;
while count<=topK

    for index_feature_ns = 1:length(not_selected_features)

            score_per_feature(not_selected_features(index_feature_ns)) = p_binf2dec(p_add_binf(fix_dec2binfm(score_per_feature(not_selected_features(index_feature_ns)),T),fix_dec2binfm(mi_sec_fix_efi_logDiv([X_data_fed(:,not_selected_features(index_feature_ns)),X_data_fed(:, selectedFeatures(count-1))], Y_labels_fed, T, n_devices, n_discret, numSamples, maxY),T)));
      
    end
    
    [val_max,selectedFeatures(count)]= max(score_per_feature,[],'omitnan');
    
   score_per_feature(selectedFeatures(count)) = NaN;
    not_selected_features = setdiff(1:numFeatures,selectedFeatures);
    count = count+1;
end