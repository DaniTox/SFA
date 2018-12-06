//
//  RegolaFetcherModel.swift
//  SFA
//
//  Created by Dani Tox on 03/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation
import CoreData

class RegolaFetcherModel {
    
    static let shared = RegolaFetcherModel()
    private init() { }

    public var persistentContainer: NSPersistentContainer?
    
//    public var regola : Regola?
    
    func createIfNotPresent() {
        assert(persistentContainer != nil, "Devi settare sto cazzo di persistentContainer prima di utilizzare questo oggetto! -> RegolaFetcherModel")
        let context = persistentContainer!.viewContext
        
        let request : NSFetchRequest<Regola> = Regola.fetchRequest()
        let regole = try? context.fetch(request)
        guard let unRegole = regole else { return }
        if unRegole.count < 1 {
            print("Creating Regola since it doesn't exist")
            self.createRegolaModel()
        } else {
            print("Regola esiste già. Non la creo in CoreData")
        }
    }

    public func createRegolaModel() {
        assert(persistentContainer != nil, "Imposta il container, maledetto!")
        
        let bundleURL = Bundle.main.url(forResource: "regola", withExtension: "json")!
        let data =  try! Data(contentsOf: bundleURL)
        do {
            let object = try JSONDecoder().decode(RegolaFile.self, from: data)
            let regola = Regola.createFromFileObject(object: object, context: persistentContainer!.viewContext)
            try regola.managedObjectContext?.save()
        } catch {
            print(error)
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
