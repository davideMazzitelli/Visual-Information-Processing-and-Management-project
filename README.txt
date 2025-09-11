Istruzioni utilizzo:

Cartelle:
	-	cleaning task: contiene script utilizzati per l'addestramento del cleaning model
			> cosine_dist_filtering.m : funzione utilizzata per il filtraggio del training set iniziale e la creazione del train set filtrato per l'addestramento del cleaning model.
			> train_cleaning_model.m : script contenente la configurazione di addestramento del cleaning model, fa uso della funzione cosine_dist_filtering.

	-	modello di classificazione: contiene gli script utilizzati per l'addestramento del modello di classificazione base e del modello fine tuned
			> train_mobilenet.m : script contenente la configurazione di addestramento del modello di classificazione base.
			> preprocessing.m : funzione utilizzata per creazione del training set del modello di classificazione fine tuned; applica alle immagini le diverse tipologie di rumore.
			> train_fine_tuned.m : script contenente la configurazione di addestramento del modello di classificazione fine tuned, fa uso della funzione preprocessing.

	-	saved_data: contiene diverse tipologie di dati salvati durante lo sviluppo del progetto per velocizzare le operazioni
			> dataset_cleaned : training set pulito mediante il metodo di eliminazione degli errori
			> features : feature del training set estratte mediante transfer learning
			> features_val_fc7 : feature del validation set estratte mediante transfer learning
			> fine_tuned_model : modello di classificazione fine tuned
			> model : modello di classificazione base
			> net_cleaning : modello di cleaning
			> niqe_val_set_deg : NIQE scores calcolati sul validation set degradato
			> original_dataset_224 : training set iniziale (dimensione immagini [224 224 3])
			> original_dataset_227 : training set iniziale (dimensione immagini [227 227 3])
			> val_set : validation set
			> val_set_deg : validation set degradato


Il File main.m contiene l'intera pipeline di esecuzione del progetto:

1.	Lettura dei dataset
	Lettura dei file CSV e creazione degli imageDatastore contenenti train set, validation set e validation set degradato 
	
	funzioni utilizzate: 
		-	read_dataset: legge i file CSV e genera gli imageDatastore 'imgs', 'val_set' e 'val_set_deg'
			IMPORTANTE:	per funzionare è necessario aggiungere le cartelle dei dataset (train_set, val_set, val_set_degraded) sullo stesso path del file main.m, per motivi di spazio non abbiamo potuto caricarli su drive 

2.	Cleaning task
	Pulizia del datastore di training dalle immagini erroneamente etichettate mediante modello di cleaning.

	funzioni utilizzate:
		-	clean_dataset: prende come parametro l'imageDatastore originale ed utilizza il modello di cleaning per eliminare dal train set le immagini errate.
		-	cleaning_model_evaluation: valutazione del metodo di cleaning utilizzato

3.	Addestramento del modello di classificazione base: 

	funzioni utilizzate:
		-	evaluate_model: valutazione del modello di classificazione base sul validation set e validation set degradato (entrambi passati come parametri)

4.	Addestramento del modello di classificazione fine tuned:

	funzioni utilizzate:
		-	evaluate_model: valutazione del modello fine tuned su validation set e validation set degradato

5.	Approcci alternativi per la classificazione su validation set degradato:
	utilizzo di no-reference image quality score (NIQE) per eliminare le immagini di bassa qualità in base al loro NIQE score

	funzioni utilizzate:
		-	NIQE_DS: genera il datastore filtrato in base al NIQE score delle immagini del validation set degradato
		-	evaluate_model: valutazione del modello fine tuned sul niqe_datastore
