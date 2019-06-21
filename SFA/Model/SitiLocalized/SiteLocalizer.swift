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

    
    /// Ottiene la lista delle diocesi dal server in modo asyncrono.
    ///
    /// - Parameter saveRecords: se true, salva le diocesi in realm altrimenti no. True di default
    /// - Parameter completion: handler che ritorna le diocesi ottenute
    func getDiocesi(saveRecords: Bool = true, completion: (([DiocesiCodable]) -> Void)? = nil) {
        let request = BasicRequest(requestType: .diocesi)
        
        let networkAgent = NetworkAgent<[DiocesiCodable]>()
        networkAgent.executeNetworkRequest(with: request) { (result) in
            switch result {
            case .success(let diocesi):
                if saveRecords { self.save(diocesi: diocesi) }
                completion?(diocesi)
            case .failure(let err):
                self.errorHandler?(err)
            }
        }
    }
    
    /// Ottiene la lista delle città dal server in modo asyncrono.
    ///
    /// - Parameter saveRecords: se true, salva le città in realm altrimenti no. True di default
    /// - Parameter completion: handler che ritorna le città ottenute
    func getCitta(saveRecords: Bool = true, completion: (([CityCodable]) -> Void)? = nil) {
        let request = BasicRequest(requestType: .cities)
        
        let networkAgent = NetworkAgent<[CityCodable]>()
        networkAgent.executeNetworkRequest(with: request) { (result) in
            switch result {
            case .success(let cities):
                if saveRecords { self.save(cities: cities) }
                completion?(cities)
            case .failure(let err):
                self.errorHandler?(err)
            }
        }
    }
    
    /// Aggiorna le diocesi che gli vengono passate prendendo i dati da Realm e le restituisce indietro
    ///
    /// - Parameter diocesis: [DiocesiCodable] - la lista delle diocesi non aggiornate
    /// - Return type - Ritorna indietro i dati aggiornati
    func updateFromLocal(diocesis: [DiocesiCodable]) -> [DiocesiCodable] {
        let realm = try! Realm()
        var allDiocesi : [DiocesiCodable] = []
        
        diocesis.forEach {
            let savedObj = realm.objects(Diocesi.self).filter(NSPredicate(format: "id == %d", $0.id)).first
            
            var newObj = $0
            newObj.isSelected = savedObj?.isSelected ?? false
            allDiocesi.append(newObj)
        }
        
        return allDiocesi
    }
    
    
    /// Aggiorna le città che gli vengono passate prendendo i dati da Realm e le restituisce indietro
    ///
    /// - Parameter diocesis: [CityCodable] - la lista delle città non aggiornate
    /// - Return type - Ritorna indietro i dati aggiornati
    func updateFromLocal(cities: [CityCodable]) -> [CityCodable] {
        let realm = try! Realm()
        var allCities : [CityCodable] = []
        
        cities.forEach {
            let savedObj = realm.objects(City.self).filter(NSPredicate(format: "id == %d", $0.id)).first
            
            var newObj = $0
            newObj.isSelected = savedObj?.isSelected ?? false
            allCities.append(newObj)
        }
        
        return allCities
    }
    
    
    /// Aggiorna le diocesi salvate in Realm: aggiunge quelle nuove ed elimina quelle che non servono più.
    ///
    /// - Parameter diocesi: lista delle diocesi che ottieni dal server (quindi in formato Codable)
    private func save(diocesi: [DiocesiCodable]) {
        let realm = try! Realm()
        realm.beginWrite()
        
        for codable in diocesi {
            if let savedObject = realm.object(ofType: Diocesi.self, forPrimaryKey: codable.id) {
                savedObject.name = codable.name
            } else {
                let newObject = Diocesi.initWith(codable: codable)
                realm.add(newObject)
            }
        }
        
        let currentSavedIDs = realm.objects(Diocesi.self).map { $0.id }
        let newIDs = diocesi.map { $0.id }
        
        let filtered = newIDs.filter { !currentSavedIDs.contains($0) }
        
        let objectsToRemove = filtered.compactMap { realm.object(ofType: Diocesi.self, forPrimaryKey: $0) }
        realm.delete(objectsToRemove)
        
        try? realm.commitWrite()
    }
    
    /// Aggiorna le città salvate in Realm: aggiunge quelle nuove ed elimina quelle che non servono più.
    ///
    /// - Parameter cities: lista delle città che ottieni dal server (quindi in formato Codable)
    private func save(cities: [CityCodable]) {
        let realm = try! Realm()
        realm.beginWrite()
        
        for codable in cities {
            if let savedObject = realm.object(ofType: City.self, forPrimaryKey: codable.id) {
                savedObject.name = codable.name
            } else {
                let newObject = City.initWith(codable: codable)
                realm.add(newObject)
            }
        }
        
        let currentSavedIDs = realm.objects(City.self).map { $0.id }
        let newIDs = cities.map { $0.id }
        
        let filtered = newIDs.filter { !currentSavedIDs.contains($0) }
        
        let objectsToRemove = filtered.compactMap { realm.object(ofType: City.self, forPrimaryKey: $0) }
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
    public func fetchLocalDiocesi() -> [DiocesiCodable] {
        let realm = try! Realm()
        
        let objects = realm.objects(Diocesi.self).map { $0 }
        var allDiocesiCodable: [DiocesiCodable] = []
        
        objects.forEach {
            let newCodable = DiocesiCodable(id: $0.id, name: $0.name, isSelected: $0.isSelected)
            allDiocesiCodable.append(newCodable)
        }
        
        return allDiocesiCodable
    }
    
    /// Ottiene tutte le città da Realm, le trasforma in codable e le ritorna
    public func fetchLocalCities() -> [CityCodable] {
        let realm = try! Realm()
        
        let objects = realm.objects(City.self).map { $0 }
        var allCitiesCodable: [CityCodable] = []
        
        objects.forEach {
            let newCodable = CityCodable(id: $0.id, name: $0.name, diocesiID: $0.diocesi.first?.id ?? -1, isSelected: $0.isSelected)
            allCitiesCodable.append(newCodable)
        }
        
        return allCitiesCodable
    }
    
    
    /// Rimuove da Realm tutti i tipi di siti salvati in locale
    private func removeAllLocalSites() {
        let realm = try! Realm()
        try? realm.write {
            realm.delete(realm.objects(SitoWeb.self))
        }
    }
    
    /// Rimuove da Realm tutti i siti di una certa diocesi
    public func removeSites(for obj: DiocesiCodable) {
        let realm = try! Realm()
        let objects = realm.objects(SitoWeb.self).filter(NSPredicate(format: "diocesi.id == %d", obj.id))
        
        try? realm.write {
            realm.delete(objects)
        }
    }
    
    /// Rimuove da Realm tutti i siti di una certa città
    public func removeSites(for obj: CityCodable) {
        let realm = try! Realm()
        let objects = realm.objects(SitoWeb.self).filter(NSPredicate(format: "city.id == %d", obj.id))
        
        try? realm.write {
            realm.delete(objects)
        }
    }
    
    
    /// Otttiene i siti custom dal server in base alla diocesi
    ///
    /// - Parameter diocesi: [DiocesiCodable] la diocesi scelta per i siti
    /// - Parameter saveRecords: dice se salvare i siti su Realm. True di default
    /// - Parameter completion: closure che viene eseguita quando si ottengono i siti con successo.
    public func fetchLocalizedWebsites(for diocesi: DiocesiCodable, saveRecords: Bool = true, completion: @escaping (LocalizedList) -> Void) {
        let idDiocesi = diocesi.id
        
        let req = BasicRequest(requestType: .localizedSites, args: ["diocesiID" : "\(idDiocesi)"])
        self.fetchFromServer(saveRecords: saveRecords, req: req) { list in
            completion(list)
        }
    }

    /// Otttiene i siti custom dal server in base alla città
    ///
    /// - Parameter city: [CityCodable] la città scelta per i siti
    /// - Parameter saveRecords: dice se salvare i siti su Realm. True di default
    /// - Parameter completion: closure che viene eseguita quando si ottengono i siti con successo.
    public func fetchLocalizedWebsites(for city: CityCodable, saveRecords: Bool = true, completion: @escaping (LocalizedList) -> Void) {
        let idCity = city.id
        
        let req = BasicRequest(requestType: .localizedSites, args: ["cittaID" : "\(idCity)"])
        self.fetchFromServer(saveRecords: saveRecords, req: req) { list in
            completion(list)
        }
    }
    
    /// Otttiene i siti delle preghiere dal server.
    ///
    /// - Parameter saveRecords: dice se salvare i siti su Realm. True di default
    /// - Parameter completion: closure che viene eseguita quando si ottengono i siti con successo.
    public func fetchPreghiereSites(saveRecords: Bool = true, completion: @escaping (LocalizedList) -> Void) {
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
    private func fetchFromServer(saveRecords: Bool, req: BasicRequest, completion: @escaping (LocalizedList) -> Void) {
        let agent = NetworkAgent<NetworkResponse<LocalizedList>>()
        agent.executeNetworkRequest(with: req) { (result) in
            switch result {
            case .success(let localizedResponse):
                if saveRecords { self.saveLocalizedSitesList(localizedResponse.object) }
                completion(localizedResponse.object)
            case .failure(let error): self.errorHandler?(error)
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
    
    /// Salva nel database lo stato della diocesi passata come parametro
    /// - Parameter diocesi: La diocesi di cui bisogna aggiornare lo stato su Realm
    public func toggle(diocesi: DiocesiCodable) {
        let realm = try! Realm()
        if let savedDiocesi = realm.objects(Diocesi.self).filter(NSPredicate(format: "id == %d", diocesi.id)).first {
            try! realm.write {
                savedDiocesi.isSelected.toggle()
            }
        }
    }
    
    /// Salva nel database lo stato della città passata come parametro
    /// - Parameter city: La città di cui bisogna aggiornare lo stato su Realm
    public func toggle(city: CityCodable) {
        let realm = try! Realm()
        if let savedDiocesi = realm.objects(City.self).filter(NSPredicate(format: "id == %d", city.id)).first {
            try! realm.write {
                savedDiocesi.isSelected.toggle()
            }
        }
    }
}
