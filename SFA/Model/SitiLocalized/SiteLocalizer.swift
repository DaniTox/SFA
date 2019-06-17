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
    
    
    /// Elimina tutte le diocesi salvate in Realm e poi salva quelle nuove passate come parametro convertendole a oggetti Realm.
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
    
    /// Elimina tutte le città salvate in Realm e poi salva quelle nuove passate come parametro convertendole a oggetti Realm.
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
