function dataset_cleaned=clean_dataset(imgs)
    %% imports
    load("saved_data/features.mat"); % import delle feature estratte in precedenza con alexnet (fc7)
    load("saved_data/net_cleaning.mat"); % import del modello di cleaning
    
    %% predizioni del modello di cleaning
    predictions = predict(net_cleaning, features);
    
    %% estrazione degli indici da mantenere
    to_keep = [];    
    class_probs = [];
    for i=0:250
        class_imgs = find(imgs.Labels(:) == num2str(i));
        for ii=1:length(class_imgs) 
            y = predictions(class_imgs(ii), :); 
            y_ = onehotencode(imgs.Labels(class_imgs(ii)),2);
            class_probs = [class_probs; y*y_'];
            to_keep = [to_keep; class_imgs(ii)];
        end  
    end
    [max_probs, indices] = maxk(class_probs, floor(0.75*length(imgs.Labels)));
    to_keep = to_keep(indices);
    
    %% 
    n_to_keep = length(to_keep);
    disp("Immagini mantenute: " + n_to_keep);
    
    %% creazione dataset pulito
    dataset_cleaned = subset(imgs, to_keep);
end