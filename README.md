# iGio for iOS

Da completare...


## Roadmap per lo sviluppo
Prima di tutto, rimuovere Realm dall'intera app visto che è stata una scelta sbagliata da parte mia (danXNU) quando ho inizialmente sviluppato l'app. 
È stata una scelta "overkill" visto che ora non vedo le necessità di avere un database anche per le cose più semplici come salvare una semplice struttura come GioUser. 
In più, ha aggiunto un livello di complessità in più all'app dove non era necessario. 
Questo sta causando rallentamenti negli aggiornamenti visto che ora, per esempio, non si possono più aggiornare le domande del "Percorso formativo" in maniera semplice ma bisognerebbe chiedere al database di modifare l'item in base a che versione dell'app è installata e bisognerebbe sapere anche se il database è già stato aggiornato in modo da non ri-aggiornarlo.

La soluzione è semplice: convertire tutto in JSON e salvare le varie strutture in file nelle directory dell'app. 
Ogni categoria avrà una cartella nel filesystem (per esempio: "User" per il salvataggio del file utene, "Verifica" per le risposte del percorso formativo, ecc.)
e all'interno delle cartelle saranno contenuti tutti i file che riguardano quella categoria.

Questo permette di avere codice molto più semplice e molto più facile da aggiornare. Il continuo read & write di file JSON ormai non è più un problema con i telefoni moderni, visto che le memorie sono sempre più veloci e noi comunque salviamo file JSON veramenti piccoli e non avrebbero problemi nemmeno i telefoni più vecchi.

Strutture già convertite in JSON:
- [x] User (GioUser)
- [x] Percorso Formativo (Verifica)
- [ ] Diario personale (JSON/RTF)
- [ ] TeenSTAR M
- [ ] TeenSTAR F
- [ ] GioProNet
- [ ] Progetto delle 3S (o equivalenti)
- [x] Angelo Custode
- [ ] Cache dei siti/social delle province/città
