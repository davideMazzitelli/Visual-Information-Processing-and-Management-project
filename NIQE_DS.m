function new_datastore = NIQE_DS(f,l)
    %%
    labels = l;
    files = f;

    %%
    load("saved_data\niqe_val_set_deg.mat") % load dei NIQE scores calcolati sul validation set degradato
   
    %%
    H = histogram(niqe_scores,10);

    binWidth = H.BinWidth;
    u = find(niqe_scores <= 10);
    new_files = files(u);
    new_labels = labels(u);
    
    v = find(niqe_scores > 10);
    bad_files = files(v);
    bad_labels = labels(v);
    %%
    new_val_set_deg = imageDatastore(new_files, 'Labels', new_labels);
    inputSize = [224 224];
    new_val_set_deg.ReadFcn = @(loc)imresize(imread(loc),inputSize);
    new_datastore = new_val_set_deg;
end