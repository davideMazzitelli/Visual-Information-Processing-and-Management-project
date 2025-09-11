load('..\saved_data\features_val_fc7.mat')
load('..\saved_data\features.mat')  % feature estratte tramite transfer learning
load('..\saved_data\original_dataset_227.mat')
load('..\saved_data\val_set.mat')   
%% prima pulizia outliers
% net = alexnet;
% analyzeNetwork(net);
% layer = 'fc7';
% features = activations(net,imgs,layer, 'OutputAs','rows'); 
% per comodità carichiamo le features già estratte in precedenza 'features.mat'
[dataset_cleaned, features_cleaned] = cosine_dist_filtering(imgs, features); 
%%
ds = features_cleaned;
labels = dataset_cleaned.Labels;

val_ds = im_val;
val_labels = val_set.Labels;

%% configurazione di training
miniBatchSize = 256;
options = trainingOptions('adam', ...
    'MiniBatchSize',miniBatchSize, ...
    'MaxEpochs',64,...
    'InitialLearnRate',1e-4,...
    'ValidationData',{val_ds, val_labels},...
    'ValidationFrequency',32,...
    'Shuffle','every-epoch', ...
    'Plots','training-progress', ...
    'OutputNetwork','best-validation-loss', ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',16, ...
    'LearnRateDropFactor',0.1, ...
    'Verbose',false ...
    );


layers = [
    featureInputLayer(4096)

    fullyConnectedLayer(4096)
    reluLayer
    batchNormalizationLayer
    dropoutLayer(0.4)

    fullyConnectedLayer(4096)
    reluLayer
    batchNormalizationLayer
    dropoutLayer(0.2)

    fullyConnectedLayer(251)
    softmaxLayer
    classificationLayer
];

%% Train
net_cleaning = trainNetwork(ds,labels,layers,options);