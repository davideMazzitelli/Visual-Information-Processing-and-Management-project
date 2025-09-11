
%% 1. Lettura Dataset
[imgs, val_set, val_set_deg] = read_dataset();

%% 2. Cleaning task
dataset_cleaned = clean_dataset(imgs); % Immagini mantenute: 88856
%%
% Cleaning Evaluation
cleaning_model_evaluation(val_set);
% miss precision: 0.68379
% miss recall: 0.85488

%% 3. Addestramento baseline model
% addestramento del modello -> vedere file 'train_mobilenet.m' nella
% cartella 'modello di classificazione'

% Lettura Dataset, rileggiamo perchè il validation set viene sporcato nella funzione
% cleaning_model_evaluation
[imgs, val_set, val_set_deg] = read_dataset();

% Evaluate Model
load("saved_data\model.mat")
fprintf("\n Evaluate Baseline model - Val Set\n")
evaluate_model(classification_model, val_set); 
% 1-Shot    3-Shot
% 0.5394    0.7354
% Precision:    0.5261
% Recall:       0.5675
%%
fprintf("\n Evaluate Baseline model - Val Set Deg\n")
evaluate_model(classification_model, val_set_deg);
% 1-Shot    3-Shot
% 0.3369    0.4805
% Precision:    0.3300
% Recall:       0.4593
%% 4.	Addestramento del modello di classificazione fine tuned
% addestramento del modello -> vedere file 'train_fine_tuned.m' nella
% cartella 'modello di classificazione'

% evaluation
load("saved_data\fine_tuned_model.mat")
fprintf("\n Evaluate Fine Tuned model - Val Set\n")
evaluate_model(fine_tuned_model, val_set);
% 1-Shot    3-Shot
% 0.5732	0.7637
% Precision:    0.5596
% Recall:       0.5772
%%
fprintf("\n Evaluate Fine Tuned model - Val Set Deg\n")
evaluate_model(fine_tuned_model, val_set_deg);
% 1-Shot    3-Shot
% 0.4613	0.6507
% Precision:    0.4507
% Recall:       0.4854
%% 5.	Approcci alternativi per la classificazione su validation set degradato
% creazione train set pulito tramite NIQE scores
niqe_datastore = NIQE_DS(val_set_deg.Files, val_set_deg.Labels);

% evaliation
fprintf("\n Evaluate Fine Tuned model - NIQE approach\n")
evaluate_model(fine_tuned_model, niqe_datastore);
% 1-Shot    3-Shot
% 0.5019	0.6970
% Precision:    0.4920
% Recall:       0.5153
