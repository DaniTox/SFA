//
//  SitiAgentModel.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import CoreData

class SitiAgent : SitiNetworkAgent {
    private var persistentContainer : NSPersistentContainer!
    
    var sitesCategories : [SitoWebCategoria] = []
    
    init(container: NSPersistentContainer) {
        super.init()
        self.persistentContainer = container
        
        //updateSites()
    }
    
    public func fetchLocalWebsites() -> [SitoWebCategoria]  {
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<SitoWebCategoria> = SitoWebCategoria.fetchRequest()
        
        if let categories = try? context.fetch(request) {
            sitesCategories = categories
            return categories
        }
        return []
    }
    
//    public func updateSites() {
//        loadSites { (categories) in
//            self.sitesCategories = categories
//        }
//    }
    
    public func loadSites(completion: (([SitoWebCategoria]) -> Void)? = nil) {
        self.getWebsites { (sites) in
            let coreDataSites = self.createCoreDataObjects(sites)
            completion?(coreDataSites)
        }
    }
    
    private func createCoreDataObjects(_ objects: [SitoCategoriaObject]) -> [SitoWebCategoria] {
        self.removeAllLocalSites()
        let context = persistentContainer.viewContext
        var siti : [SitoWebCategoria] = []
        
        for categoria in objects {
            let categoriaCD = SitoWebCategoria(context: context)
            categoriaCD.name = categoria.name
            categoriaCD.idOrder = Int16(categoria.idOrder)
            categoriaCD.descrizione = categoria.descrizione
            
            for sito in categoria.sites {
                let sitoCD = SitoWeb(context: context)
                sitoCD.nome = sito.nome
                sitoCD.descrizione = sito.descrizione
                sitoCD.idOrder = Int16(sito.idOrder)
                sitoCD.url = URL(string: sito.url)
                categoriaCD.addToSitiWeb(sitoCD)
            }
            siti.append(categoriaCD)
        }
        try? context.save()
        return siti
    }
    
    
    private func removeAllLocalSites() {
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<SitoWebCategoria> = SitoWebCategoria.fetchRequest()
        if let sites = try? context.fetch(request) {
            sites.forEach( { context.delete($0) } )
        }
        try? context.save()
    }
}
