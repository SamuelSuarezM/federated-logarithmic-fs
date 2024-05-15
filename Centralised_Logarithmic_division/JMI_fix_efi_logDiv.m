function [selectedFeatures] = JMI_fix_efi_logDiv(X_data,Y_labels, topK, T)
% Summary 
%    JMI algorithm for feature selection
% Inputs
%    X_data: n x d matrix X, with categorical values for n examples and d features
%    Y_labels: n x 1 vector with the labels
%    topK: Number of features to be selected
%    T: number of fractional bits

numFeatures = size(X_data,2);

score_per_feature = zeros(1,numFeatures);

for index_feature = 1:numFeatures
    score_per_feature(index_feature) = mi_fix_efi_logDiv(X_data(:,index_feature),Y_labels, T);
end

selectedFeatures = zeros(1,topK);
[val_max,selectedFeatures(1)]= max(score_per_feature);

not_selected_features = setdiff(1:numFeatures,selectedFeatures);


score_per_feature =  zeros(1,numFeatures);
score_per_feature(selectedFeatures(1)) =  NaN;
count = 2;
while count<=topK

    for index_feature_ns = 1:length(not_selected_features)

            score_per_feature(not_selected_features(index_feature_ns)) = p_binf2dec(p_add_binf(fix_dec2binfm(score_per_feature(not_selected_features(index_feature_ns)),T),fix_dec2binfm(mi_fix_efi_logDiv([X_data(:,not_selected_features(index_feature_ns)),X_data(:, selectedFeatures(count-1))], Y_labels, T),T)));
      
    end
    
    [val_max,selectedFeatures(count)]= max(score_per_feature,[],'omitnan');
    
   score_per_feature(selectedFeatures(count)) = NaN;
    not_selected_features = setdiff(1:numFeatures,selectedFeatures);
    count = count+1;
end