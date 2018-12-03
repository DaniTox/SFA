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
    
//    static let shared = RegolaFetcherModel()
//    private init() { }

    public var persistentContainer: NSPersistentContainer?
    
    public var regola : Regola?
    
    func createIfNotPresent() {
        assert(persistentContainer != nil, "Devi settare sto cazzo di persistentContainer prima di utilizzare questo oggetto! -> RegolaFetcherModel")
        let context = persistentContainer!.viewContext
        
        let request : NSFetchRequest<Regola> = Regola.fetchRequest()
        let regole = try? context.fetch(request)
        guard let unRegole = regole else { return }
        if unRegole.count < 1 {
            print("Creating Regola since it doesn't exist")
            self.createFromFile()
        } else {
            print("Regola esiste già. Non la creo in CoreData")
        }
    }

    
    private func createFromFile() {
        assert(persistentContainer != nil, "Devi settare sto cazzo di persistentContainer prima di utilizzare questo oggetto! -> RegolaFetcherModel")
        let context = persistentContainer!.viewContext
        
        let bundleUrl = Bundle.main.url(forResource: "regola", withExtension: "json")!
        guard let data = try? Data(contentsOf: bundleUrl) else { return }
        var regolaFile : RegolaFile = RegolaFile()
        do {
            regolaFile = try JSONDecoder().decode(RegolaFile.self, from: data)
        } catch {
            print(error)
        }
        
//        let regolaCoreData = Regola(context: context)
//        let categorieFile = regolaFile.categories
//        for (indexCat, categoriaFile) in categorieFile.enumerated() {
//            let categoriaCoreData = Categoria(context: context)
//            categoriaCoreData.id = Int16(indexCat)
//            categoriaCoreData.name = categoriaFile.name
//        }
        
        do {
            try context.save()
        } catch {
            print("Context: error while saving the new Regola from File... fuck this shit")
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
        if self.regola != nil {
            return self.regola
        } else {
            return try? self.getLatestRegola()
        }
    }
    
}
