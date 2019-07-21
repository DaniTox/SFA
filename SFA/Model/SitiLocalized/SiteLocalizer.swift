//
//  SiteLocalizer.swift
//  MGS
//
//  Created by Dani Tox on 16/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import RealmSwift

class SiteLocalizer {
    
    var errorHandler: ((Error) -> Void)?

    
    /// Ottiene la lista delle location (diocesi o città) dal server in modo asyncrono.
    ///
    /// - Parameter type: indica quale location si vuole ricevere
    /// - Parameter saveRecords: se true, salva le diocesi in realm altrimenti no. True di default
    /// - Parameter completion: handler che ritorna le diocesi ottenute
    func getLocations(of type: LocationType, saveRecords: Bool = true, completion: (([LocationCodable]) -> Void)? = nil) {
        var request = BasicRequest(requestType: .locations)
        request.args = ["type": "\(type.rawValue)"]
        
        let networkAgent = NetworkAgent<[LocationCodable]>()
        networkAgent.executeNetworkRequest(with: request) { (result) in
            switch result {
            case .success(let diocesi):
                if saveRecords { self.save(locations: diocesi) }
                completion?(diocesi)
            case .failure(let err):
                self.errorHandler?(err)
            }
        }
    }
    
    
    /// Aggiorna le locations che gli vengono passate prendendo i dati da Realm e le restituisce indietro
    ///
    /// - Parameter diocesis: [LocationCodable] - la lista delle locations non aggiornate
    /// - Return type - Ritorna indietro i dati aggiornati
    func updateFromLocal(locations: [LocationCodable]) -> [LocationCodable] {
        let realm = try! Realm()
        var allLocations : [LocationCodable] = []
        
        locations.forEach {
            let savedObj = realm.objects(Location.self).filter(NSPredicate(format: "id == %d", $0.id)).first
            
            var newObj = $0
            newObj.isSelected = savedObj?.isSelected ?? false
            allLocations.append(newObj)
        }
        
        return allLocations
    }
    
    
    /// Aggiorna le locations salvate in Realm: aggiunge quelle nuove ed elimina quelle che non servono più.
    ///
    /// - Parameter diocesi: lista delle diocesi che ottieni dal server (quindi in formato Codable)
    private func save(locations: [LocationCodable]) {
        let realm = try! Realm()
        realm.beginWrite()
        
        for codable in locations {
            if let savedObject = realm.object(ofType: Location.self, forPrimaryKey: codable.id) {
                savedObject.name = codable.name
            } else {
                let newObject = Location.initWith(codable: codable)
                realm.add(newObject)
            }
        }
        
        let currentSavedIDs = realm.objects(Location.self).map { $0.id }
        let newIDs = locations.map { $0.id }
        
        let filtered = newIDs.filter { !currentSavedIDs.contains($0) }
        
        let objectsToRemove = filtered.compactMap { realm.object(ofType: Location.self, forPrimaryKey: $0) }
        realm.delete(objectsToRemove)
        
        try? realm.commitWrite()
    }
    

    /// Ottiene i siti dal Realm locale in base alla categoria passata com arg
    ///
    /// - Parameter type: SitoCategoria - il tipo di siti da ottenere
    /// - Returns: [SitoObject] ritorna i siti richiesti presi da Realm
    public func fetchLocalWebsites(type: SitoCategoria) -> [SitoObject]  {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "_categoria == %d", type.rawValue)
        return realm.objects(SitoWeb.self).filter(predicate).map { SitoObject.initFrom(obj: $0) }
    }
    
    /// Ottiene tutte le diocesi da Realm, le trasforma in codable e le ritorna
    /// - Parameter type: LocationType - il tipo di location da ottenere
    public func fetchLocalLocations(of type: LocationType) -> [LocationCodable] {
        let realm = try! Realm()
        
        let objects = realm.objects(Location.self).filter(NSPredicate(format: "_type == %d", type.rawValue)).map { $0 }
        var allDiocesiCodable: [LocationCodable] = []
        
        objects.forEach {
            let newCodable = LocationCodable(id: $0.id, name: $0.name, type: type, isSelected: $0.isSelected)
            allDiocesiCodable.append(newCodable)
        }
        
        return allDiocesiCodable
    }
    
    
    /// Rimuove da Realm tutti i tipi di siti salvati in locale
    private func removeAllLocalSites() {
        let realm = try! Realm()
        try? realm.write {
            realm.delete(realm.objects(SitoWeb.self))
        }
    }
    
    /// Rimuove da Realm tutti i siti di una certa location
    public func removeSites(for obj: LocationCodable) {
        let realm = try! Realm()
        let objects = realm.objects(SitoWeb.self).filter(NSPredicate(format: "location.id == %d", obj.id))
        
        try? realm.write {
            realm.delete(objects)
        }
    }
    
    /// Otttiene i siti custom dal server in base alla diocesi
    ///
    /// - Parameter diocesi: [DiocesiCodable] la diocesi scelta per i siti
    /// - Parameter saveRecords: dice se salvare i siti su Realm. True di default
    /// - Parameter completion: closure che viene eseguita quando si ottengono i siti con successo.
    public func fetchLocalizedWebsites(for location: LocationCodable, saveRecords: Bool = true, completion: @escaping (Result<LocalizedList, Error>) -> Void) {
        let locationID = location.id
        
        let req = BasicRequest(requestType: .localizedSites, args: ["locationID" : "\(locationID)"])
        self.fetchFromServer(saveRecords: saveRecords, req: req) { listResult in
            completion(listResult)
        }
    }
    
    /// Ottiene tutte le location salvate di un certo tipo su Realm che l'utente ha scelto di seguire (isSelected == true)
    private func getLocalSelectedLocation(of type: LocationType) -> [LocationCodable] {
        let realm = try! Realm()
        return realm.objects(Location.self).filter(NSPredicate(format: "_type == %d", type.rawValue)).filter(NSPredicate(format: "isSelected == YES")).map { LocationCodable.initFrom(realmObject: $0) }
    }
    
    /// Ottiene tutte le location salvate su Realm che l'utente ha scelto di seguire (isSelected == true)
    private func getAllLocalSelectedLocations() -> [LocationCodable] {
        let realm = try! Realm()
        return realm.objects(Location.self).filter(NSPredicate(format: "isSelected == YES")).map { LocationCodable.initFrom(realmObject: $0) }
    }
    
    /// Aggiorna dal server tutti i siti in base alle diocesi/città selezionate, aggiungendo i siti preghiere e ritornando il risultato nella completionHandler. La completion può contenere o la lista di tutti i siti scaricati o eventuale errore
    /// - Parameter saveRecords: se true, salva i siti scaricati su Realm. true di default.
    /// - Parameter completion: handler che riporta o eventuali siti scaricati o errore
    public func fetchAllWebsites(saveRecords: Bool = true, completion: @escaping (Result<LocalizedList, Error>) -> Void) {
        let locations = getAllLocalSelectedLocations()

        var allSites: Set<SitoObject> = []
        var error: Error?
        
        let group = DispatchGroup()

        for location in locations {
            group.enter()
            self.fetchLocalizedWebsites(for: location) { (result) in
                switch result {
                case .success(let list):
                    allSites.formUnion(list.siti)
//                    allSites.append(contentsOf: list.siti)
                case .failure(let err):
                    error = err
                }
                group.leave()
            
            }
        }
        
        
        group.notify(queue: .main) {
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            let list = LocalizedList(siti: Array(allSites).sorted(by: { $0.type.rawValue < $1.type.rawValue }))
            completion(.success(list))
            
        }
    }
    
    
    /// Otttiene i siti delle preghiere dal server.
    ///
    /// - Parameter saveRecords: dice se salvare i siti su Realm. True di default
    /// - Parameter completion: closure che viene eseguita quando si ottengono i siti con successo.
    @available(*, deprecated)
    public func fetchPreghiereSites(saveRecords: Bool = true, completion: @escaping (Result<LocalizedList, Error>) -> Void) {
        print("Non dovrebbe servire più perchè l'API nel server ritorna in automatico anche le preghiere quando si richiedono gli altri siti")
        let req = BasicRequest(requestType: .preghiere)
        self.fetchFromServer(saveRecords: saveRecords, req: req) { (list) in
            completion(list)
        }
    }
    
    
    /// Questa funzione è quella che effettivamente chiede la lista localizzata dei siti/social al server.
    /// Poi li ritorna al chiamante tramite una completionHandler. Se invece fallisce, chiama l'errorHandler dell'istanza
    ///
    /// - Parameter saveRecords: dice se salvare i siti su Realm.
    /// - Parameter req: [BasicRequest] la richiesta contenente gli args da mandare al server
    /// - Parameter completion: manda la lista dei siti localizzati ottenuti
    private func fetchFromServer(saveRecords: Bool, req: BasicRequest, completion: @escaping (Result<LocalizedList, Error>) -> Void) {
        let agent = NetworkAgent<LocalizedList>()
        agent.executeNetworkRequest(with: req) { (result) in
            switch result {
            case .success(let localizedResponse):
                if saveRecords { self.saveLocalizedSitesList(localizedResponse/*.object*/) }
                completion(.success(localizedResponse/*.object*/))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// Salva la lista dei social & sites su Realm modificando quelli esistenti e aggiungendo quelli nuovi
    private func saveLocalizedSitesList(_ sites: LocalizedList) {
        let realm = try! Realm()
        realm.beginWrite()
        
        let allWebsites = sites.siti
        
        for codableSite in allWebsites {
            if let savedSite = realm.objects(SitoWeb.self).filter(NSPredicate(format: "id == %d", codableSite.id)).first {
                savedSite.updateContents(from: codableSite)
            } else {
                let newSite = SitoWeb.initFrom(codable: codableSite)
                realm.add(newSite)
            }
        }
        
        try? realm.commitWrite()
    }
    
    /// Salva nel database lo stato della location passata come parametro
    /// - Parameter location: La location di cui bisogna aggiornare lo stato su Realm
    public func toggle(location: LocationCodable) {
        let realm = try! Realm()
        if let savedLocation = realm.objects(Location.self).filter(NSPredicate(format: "id == %d", location.id)).first {
            try! realm.write {
                savedLocation.isSelected.toggle()
            }
        }
    }
    
}
