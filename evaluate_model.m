function evaluate_model(model, datastore)
    L = predict(model,datastore);

    out=L;
    [prob, idx] = maxk(out,5,2);
    labels = datastore.Labels;
    labels = double(labels);
    
    disp("One shot")
    A = idx(:, [1]) == labels(:,1);
    numel(find(A(:) == 1))/size(A,1)

    C = confusionmat(labels,idx(:, [1]));
    precisions = [];
    recalls = [];
    for ii = 1:size(C,1)
        D = C(ii,ii);
        ROW = C(ii,:);
        COL = C(:,ii);
        precisions = [precisions; D/sum(ROW)];
        recalls = [recalls; D/sum(COL)];
    end
    disp("Precision: ")
    precisions(isnan(precisions)) = 0;
    prec = mean(precisions)
    disp("Recall: ")
    recalls(isnan(recalls)) = 0;
    rec = mean(recalls)

    disp("Three shot")
    A = idx(:, [1,2,3]) == labels(:,1);
    numel(find(A(:) == 1))/size(A,1)

end