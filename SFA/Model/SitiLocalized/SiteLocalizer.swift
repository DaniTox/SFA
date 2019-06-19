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
    
    /// Ottiene i siti dal Realm locale
    ///
    /// - Parameter type: [SitoCategoria] il tipo di siti da ottenere
    /// - Returns: [SitoWeb] ritorna i siti richiesti presi da Realm
    public func fetchLocalWebsites(type: SitoCategoria) -> [SitoWeb]  {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "ANY _categoria == %d", type.rawValue)
        return realm.objects(SitoWeb.self).filter(predicate).map { $0 }
    }
    
    
    /// Rimuove da Realm tutti i tipi di siti salvati in locale
    private func removeAllLocalSites() {
        let realm = try! Realm()
        try? realm.write {
            realm.delete(realm.objects(SitoWeb.self))
        }
    }
    
    /// Otttiene i siti custom dal server in base alla diocesi
    ///
    /// - Parameter diocesi: [DiocesiCodable] la diocesi scelta per i siti
    /// - Parameter completion: closure che viene eseguita quando si ottengono i siti con successo.
    public func fetchLocalizedWebsites(for diocesi: DiocesiCodable, completion: @escaping (LocalizedList) -> Void) {
        let idDiocesi = diocesi.id
        
        let req = BasicRequest(requestType: .localizedSites, args: ["diocesiID" : "\(idDiocesi)"])
        self.fetchFromServer(req: req) { list in
            completion(list)
        }
    }

    /// Otttiene i siti custom dal server in base alla città
    ///
    /// - Parameter city: [CityCodable] la città scelta per i siti
    /// - Parameter completion: closure che viene eseguita quando si ottengono i siti con successo.
    public func fetchLocalizedWebsites(for city: CityCodable, completion: @escaping (LocalizedList) -> Void) {
        let idCity = city.id
        
        let req = BasicRequest(requestType: .localizedSites, args: ["cittaID" : "\(idCity)"])
        self.fetchFromServer(req: req) { list in
            completion(list)
        }
    }
    
    /// Questa funzione è quella che effettivamente chiede la lista localizzata dei siti/social al server.
    /// Poi li ritorna al chiamante tramite una completionHandler. Se invece fallisce, chiama l'errorHandler dell'istanza
    ///
    /// - Parameter req: [BasicRequest] la richiesta contenente gli args da mandare al server
    /// - Parameter completion: manda la lista dei siti localizzati ottenuti
    private func fetchFromServer(req: BasicRequest, completion: @escaping (LocalizedList) -> Void) {
        let agent = NetworkAgent<NetworkResponse<LocalizedList>>()
        agent.executeNetworkRequest(with: req) { (result) in
            switch result {
            case .success(let localizedResponse):
                completion(localizedResponse.object)
            case .failure(let error): self.errorHandler?(error)
            }
        }
    }
}
