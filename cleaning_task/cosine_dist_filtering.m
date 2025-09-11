function [dataset_cleaned, features_cleaned] = cosine_dist_filtering(dataset, features)

idx = [];
for x=0:250

    class_imgs = find(dataset.Labels(:) == num2str(x));
    class_features = features(class_imgs,:);

    mean_feature = mean(class_features, 1);
    distances = pdist2(class_features, mean_feature, 'cosine'); 
    idx = [idx; class_imgs(abs(zscore(log(distances))) <= 1.5)];
end

disp("N. miss found: ");
disp(length(dataset.Labels)-length(idx));

dataset_cleaned = subset(dataset, idx);
features_cleaned = features(idx, :);

end