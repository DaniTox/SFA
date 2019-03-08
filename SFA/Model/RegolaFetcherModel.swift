//
//  RegolaFetcherModel.swift
//  SFA
//
//  Created by Dani Tox on 03/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation
import CoreData
import RealmSwift

class RegolaFetcherModel {
    
    static let shared = RegolaFetcherModel()
    private init() { }

    public var persistentContainer: NSPersistentContainer?
    
//    public var regola : Regola?
    
    func createIfNotPresent() {
        let realm = try! Realm()
        let allRegole = realm.objects(RegolaVita.self)
        if allRegole.count < 1 {
            createRegolaModel()
        }
    }

    public func createRegolaModel() {
        let path = Bundle.main.path(forResource: "regola", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let regolaFile = try! JSONDecoder().decode(RegolaFile.self, from: data)
        
        let newRegola = RegolaVita.createFromFile(regolaFile: regolaFile)
        let realm = try! Realm()
        try? realm.write {
            realm.add(newRegola)
        }
    }
    
    private func getLatestRegola() throws -> RegolaVita {
        let realm = try! Realm()
        let regole = realm.objects(RegolaVita.self)
        if let regola = regole.first {
            return regola
        } else {
            throw ToxException.regola("Errore regola database. Contatta lo sviluppatore")
        }
    }
    
    public func getRegola() -> RegolaVita? {
        return try? self.getLatestRegola()
    }
    
    
    
    public func getDomande(from category: RegolaCategoria) -> [RegolaDomanda] {
        let realm = try! Realm()
        let domande = realm.objects(RegolaDomanda.self).filter(NSPredicate(format: "categoria = %@", category))
        return domande.compactMap { $0 }
    }
    
}
