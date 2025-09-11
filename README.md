# Visual-Information-Processing-and-Management-project

## Specifiche di progetto
A partire dal dataset FoodX-251 il gruppo deve definire un progetto originale su tutto l’archivio o su un suo sottoinsieme. L’eventuale scelta del sottoinsieme deve essere motivata.

Il progetto consiste nella progettazione, realizzazione, e valutazione di un sistema e/o app che usi il DB di immagini selezionato e che abbia almeno le seguenti componenti obbligatorie:
- Pulizia del training set da immagini non appartenenti alla categoria cibo corretta (a titolo indicativo circa il 20% del training set ha labels scorrette)
- Classificazione del validation set nelle 251 classi previste dal dataset (fine-grained food classification)
- Classificazione del validation set degraded nelle 251 classi previste dal dataset (fine-grained food classification) secondo approcci non necessariamente alternativi:
  - Identificazione e rimozione di immagini a bassa qualità
  - Miglioramento unsupervised delle immagini a bassa qualità
  - Addestramento del classificatore per trattare tramite data augmentation anche le immagini a bassa qualità
- Valutazione oggettiva dei risultati di classificazione
- Analisi visuale di casi considerati significativi

## Descrizione dataset

- 251 classi
- Train set: 118475 immagini, circa 100 a circa 600 immagini per classe, se serve un validation set è da estrarre dal training set
- Validation set: 11994 immagini, da utilizzare come primo test set, rappresentativo delle condizioni di acquisizione ottimali
- Validation set degraded: 11994 immagini, da utilizzare come vero test set, rappresentativo delle condizioni di acquisizione non ottimali
- Test set: NON lo useremo, dato che non ha la ground truth
- Annotazioni: ground truth associata al training e al validation set 
