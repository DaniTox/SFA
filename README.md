# iGio for iOS

Da completare...


## Roadmap per lo sviluppo
Qui vengono elencati gli obbiettivi da raggiungere lato codice. Oltre a questo, sono stati commessi alcuni errori durante lo sviluppo iniziale dell'app. Per questo, ho dato inizio ad una "transizione" dove piano piano, si aggiornerà il codice per soddisfare questi obbiettivi.

### Realm
Prima di tutto, rimuovere Realm dall'intera app visto che è stata una scelta sbagliata da parte mia (danXNU) quando ho inizialmente sviluppato l'app. 
È stata una scelta "overkill" visto che ora non vedo le necessità di avere un database anche per le cose più semplici come salvare una semplice struttura come GioUser. 
In più, ha aggiunto un livello di complessità in più all'app che non era necessario. 
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


### SwiftUI
Con l'arrivo di SwiftUI in iOS 13 (2019), la creazione del codice per l'interfaccia utente si è molto velocizzata. Purtroppo per utilizzare questa tecnologia, i dispositivi devono essere aggiornati ad iOS 13. Anzi, per utilizzare le ultime uscite in "SwiftUI 2" bisogna avere per forza iOS 14.
L'app iGio al momento (dicembre 2020) richiede iOS 11 per essere installata. Analizzando i dati di App Store Connect sull'utilizzo di iGio su iOS, si nota però che nessun dispositivo sta utilizzando o ha utilizzato iGio su iOS 11. Anzi, la versione meno recente che viene utilizzata per iGio da un utente, è iOS 12.4 e il dato risale comunque a qualche mese fa. Per questo motivo, tenere il supporto ad una versione così lontana dall'attuale non ripaga il peso di supportarla. Nonostante ciò, bisogna tenere in considerazione che l'app non è stata utilizzata a scuola come si voleva fare, a causa della pandemia. Quindi non possiamo sapere se in futuro qualcuno con un dispositivo più vecchio, proverà a scaricare iGio.
In conclusione, quello che ho in mente di fare è:
- Tenere la versione minima ad iOS 11
- Tutti gli aggiornamenti di funzionalità che verranno richiesti, saranno aggiunti **SOLO** per chi ha iOS 13/14 o superiore utilizzando un semplice 'if #available(iOS 14, *)'
- Se in futuro si vedranno molti utenti con versione meno recente di iOS 13/14, allora a quel punto si porterà le nuove funzionalità anche a quei sistemi
