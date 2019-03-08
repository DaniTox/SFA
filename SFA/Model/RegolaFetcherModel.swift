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
    
    private func getLatestRegola() throws -> Regola {
        assert(persistentContainer != nil, "Devi settare sto cazzo di persistentContainer prima di utilizzare questo oggetto! -> RegolaFetcherModel")
        let context = persistentContainer!.viewContext
        
        let request : NSFetchRequest<Regola> = Regola.fetchRequest()
        do {
            let regole = try context.fetch(request)
            if regole.count < 1 {
                throw LocalDBError.inconsistency("Regole nel database: \(regole.count)")
            }
            guard let regola = regole.first else {
                throw LocalDBError.foundNil("Ho fetchato il database correttamente, però la lista regole è vuota")
            }
            return regola
        } catch {
            throw error
        }
    }
    

    
    public func getRegola() -> Regola? {
        assert(persistentContainer != nil, "Devi settare sto cazzo di persistentContainer prima di utilizzare questo oggetto! -> RegolaFetcherModel")
//        if self.regola != nil {
//            return self.regola
//        } else {
            return try? self.getLatestRegola()
//        }
    }
    
    
    
    public func getDomande(from category: Categoria) -> [Domanda] {
        let context = persistentContainer!.viewContext
        let request: NSFetchRequest<Domanda> = Domanda.fetchRequest()
        request.predicate = NSPredicate(format: "categoria = %@", category)
        
        var domande : [Domanda] = []
        do {
            domande = try context.fetch(request)
        } catch {
            print("error CoreData getDomande: \(error)")
        }
        
        return domande
    }
    
}
