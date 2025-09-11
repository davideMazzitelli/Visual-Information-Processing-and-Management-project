function [imgs,val_set,val_set_deg]=read_dataset()

    % READ TRAIN
    data = readtable("train_info_dirty.csv");
    directoryImages = 'train_set';
    imgs = imageDatastore(fullfile(directoryImages, data.Var1), 'Labels', categorical(data.Var2));
    inputSize = [224 224];
    imgs.ReadFcn = @(loc)imresize(imread(loc),inputSize);

    % READ VAL
    data = readtable("val_info.csv");
    directoryImages = 'val_set';
    val_set = imageDatastore(fullfile(directoryImages, data.Var1), 'Labels', categorical(data.Var2));
    inputSize = [224 224];
    val_set.ReadFcn = @(loc)imresize(imread(loc),inputSize);

    % READ VAL DEG
    data = readtable("val_info.csv");
    directoryImages = 'val_set_degraded';
    val_set_deg = imageDatastore(fullfile(directoryImages, data.Var1), 'Labels', categorical(data.Var2));
    inputSize = [224 224];
    val_set_deg.ReadFcn = @(loc)imresize(imread(loc),inputSize);

end