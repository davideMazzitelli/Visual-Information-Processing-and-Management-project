load('..\saved_data\dataset_cleaned.mat');
%%
net = mobilenetv2;
analyzeNetwork(net)
%% cut layers
lgraph = net.layerGraph;
layers = [
    fullyConnectedLayer(4096, Name='fc')
    dropoutLayer(0.5)
    fullyConnectedLayer(251, Name="fc_out")
    softmaxLayer
    classificationLayer
];
new_lgraph = layerGraph(layers);


nlgraph = removeLayers(lgraph,'ClassificationLayer_Logits');
nlgraph = removeLayers(nlgraph,'Logits_softmax');
nlgraph = removeLayers(nlgraph,"Logits");

net1 = addLayers(nlgraph, new_lgraph.Layers);

net = connectLayers(net1, 'global_average_pooling2d_1', 'fc');

analyzeNetwork(net)
%% data augmentation
[train_set, val_set] = splitEachLabel(dataset_cleaned, 0.8,'randomized');
augmenter = imageDataAugmenter( ...
    'RandRotation',[0 360], ...
    'RandXTranslation',[-10 10], ...
    'RandYTranslation',[-10, 10]);
aug_imgs = augmentedImageDatastore([224 224 3],train_set,"DataAugmentation",augmenter );
aug_val_set = augmentedImageDatastore([224 224 3],val_set);

%% configurazione fine-tuning
options = trainingOptions('adam',...
    'MiniBatchSize',16,...
    'MaxEpochs',16,...
    'InitialLearnRate',1e-4,...
    'Shuffle','every-epoch',...
    'ValidationData',aug_val_set,...
    'ValidationFrequency',2048,...
    'Verbose',1,...
    'Plots','training-progress', ...
    'OutputNetwork','best-validation-loss' ...
     );
%%
classification_model = trainNetwork(aug_imgs,net,options);
