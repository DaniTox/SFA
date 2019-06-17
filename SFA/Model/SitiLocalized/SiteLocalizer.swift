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
    
    /// Struttura di una richiesta. Contiene solo la requestType che è la path del server.
    /// - Esempio: requestType = "example" --> suppstudenti.com:5000/example
    struct BasicRequest: ToxNetworkRequest {
        var requestType: String
    }
    
    var errorHandler: ((Error) -> Void)?

    
    /// Ottiene la lista delle diocesi dal server in modo asyncrono
    ///
    /// - Parameter completion: Se viene passato questo arg, la funzione ti ritorna le diocesi passandole come arg a questa closure. Se è nil, le diocesi vengono salvate su Realm
    func getDiocesi(completion: (([DiocesiCodable]) -> Void)? = nil) {
        let completionHandler = (completion == nil) ? save : completion!
        
        let request = BasicRequest(requestType: "diocesi")
        
        let networkAgent = NetworkAgent<[DiocesiCodable]>()
        networkAgent.executeNetworkRequest(with: request) { (result) in
            switch result {
            case .success(let diocesi):
                completionHandler(diocesi)
            case .failure(let err):
                self.errorHandler?(err)
            }
        }
    }
    
    /// Ottiene la lista delle città dal server in modo asyncrono
    ///
    /// - Parameter completion: Se viene passato questo arg, la funzione ti ritorna le città passandole come arg a questa closure. Se è nil, le città vengono salvate su Realm
    func getCitta(completion: (([CityCodable]) -> Void)? = nil) {
        let completionHandler = (completion == nil) ? save : completion!
        
        let request = BasicRequest(requestType: "citta")
        
        let networkAgent = NetworkAgent<[CityCodable]>()
        networkAgent.executeNetworkRequest(with: request) { (result) in
            switch result {
            case .success(let cities):
                completionHandler(cities)
            case .failure(let err):
                self.errorHandler?(err)
            }
        }
    }
    
    
    /// Salva su Realm le diocesi che gli vengono passate. Prima di farlo, viene creata la loro versione di Realm e poi vengono salvate.
    ///
    /// - Parameter diocesi: lista delle diocesi che ottieni dal server (quindi in formato Codable)
    private func save(diocesi: [DiocesiCodable]) {
        let realm = try! Realm()
        realm.beginWrite()
        
        realm.delete(realm.objects(Diocesi.self))
        
        for dCodable in diocesi {
            let newDiocesi = Diocesi.initWith(codable: dCodable)
            realm.add(newDiocesi)
        }
        
        try? realm.commitWrite()
    }
    
    /// Salva su Realm le città che gli vengono passate. Prima di farlo, viene creata la loro versione di Realm e poi vengono salvate.
    ///
    /// - Parameter cities: lista delle città che ottieni dal server (quindi in formato Codable)
    private func save(cities: [CityCodable]) {
        let realm = try! Realm()
        realm.beginWrite()
        
        realm.delete(realm.objects(City.self))
        
        for dCodable in cities {
            let newCity = City.initWith(codable: dCodable)
            realm.add(newCity)
        }
        
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
}
