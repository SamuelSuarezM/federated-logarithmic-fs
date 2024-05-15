function [selectedFeatures] = MIM_fed_sec(X_data, Y_labels, topK,  T, n_devices)
% Summary 
%    MIM algorithm for feature selection
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

[X_data_fed, Y_labels_fed] = divide_data(equal, Y_labels, n_devices, 123);

numFeatures = size(X_data,2);
numSamples = size(X_data,1);
score_per_feature = zeros(1,numFeatures);

for index_feature = 1:numFeatures
    score_per_feature(index_feature) = mi_sec_fix_efi_logDiv(X_data_fed(:,index_feature),Y_labels_fed, T, n_devices, n_discret, numSamples, maxY);
end

[~,selectedFeatures] = sort(score_per_feature,'descend');

selectedFeatures = selectedFeatures(1:topK);