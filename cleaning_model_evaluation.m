function cleaning_model_evaluation(val_set)
    load("saved_data\features_val_fc7.mat"); % load delle features di val_set estratte tramite transfer learning
    imgs = val_set;
    features = im_val;
    
    %%
    val_set_cleaning_model = imgs;
    allImages = val_set_cleaning_model.Files;
    numImages = numel(allImages);
    numImagesToChange = floor(0.2 * numImages);
    
    randomIndices = randperm(numImages, numImagesToChange);
    labels = unique(val_set_cleaning_model.Labels);
    for i=1:numImagesToChange
        val_set_cleaning_model.Labels(randomIndices(i)) = labels(randi(length(labels)));
    end
    
    %%
    load("saved_data\net_cleaning.mat");
    predictions = predict(net_cleaning, features);
    
    %%
    to_remove = [];    
    class_probs = [];
    for i=0:250
        class_imgs = find(val_set_cleaning_model.Labels(:) == num2str(i));
        for ii=1:length(class_imgs) % da vedere
            y = predictions(class_imgs(ii), :); 
            y_ = onehotencode(val_set_cleaning_model.Labels(class_imgs(ii)),2);
            class_probs = [class_probs; y*y_'];
            to_remove = [to_remove; class_imgs(ii)];
        end  
    end
    [min_probs, indices] = mink(class_probs, floor(0.25*length(val_set_cleaning_model.Labels)));
    to_remove_ = to_remove(indices);
    
    %%
    disp("miss precision: " + length(intersect(to_remove_, randomIndices))/length(to_remove_))
    disp("miss recall: " +length(intersect(to_remove_, randomIndices))/length(randomIndices))

end