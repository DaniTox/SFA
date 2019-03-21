//
//  SitiAgentModel.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import RealmSwift

class SitiAgent : SitiNetworkAgent {
    
    var sites : [SitoWeb] = []
    
    public func fetchLocalWebsites(type: WebsiteType) -> [SitoWeb]  {
        let realm = try! Realm()
        switch type {
        case .materiali:
            let predicate = NSPredicate(format: "self.categoria.idCategoriaType == %d", WebsiteType.materiali.rawValue)
            return realm.objects(SitoWeb.self).filter(predicate).map { $0 }
        case .preghiere:
            let predicate = NSPredicate(format: "self.categoria.idCategoriaType == %d", WebsiteType.preghiere.rawValue)
            return realm.objects(SitoWeb.self).filter(predicate).map { $0 }
        }
    }
    
    public func loadSites(type: WebsiteType, completion: (([SitoWeb]) -> Void)? = nil) {
        self.getWebsites(type: type) { (sites, categoria) in
            let databaseSites = self.convertAndSave(siti: sites, for: categoria)
            completion?(databaseSites)
        }
    }
    
    private func convertAndSave(siti: [SitoObject], for categoria: SitoCategoriaObject) -> [SitoWeb] {
        self.removeAllLocalSites()
        let realm = try! Realm()
        
        let newCategoria = SitoWebCategoria()
        newCategoria.idCategoriaType = categoria.id ?? -1
        newCategoria.nome = categoria.nome
        newCategoria.descrizione = categoria.descrizione ?? ""
        newCategoria.order = categoria.order
        
        var newSites: [SitoWeb] = []
        
        for sito in siti {
            let newSito = SitoWeb()
            newSito.nome = sito.nome
            newSito.descrizione = sito.descrizione ?? ""
            newSito.order = sito.order ?? 0
            
            newSites.append(newSito)
        }
        
        newCategoria.siti.append(objectsIn: newSites)
        
        try? realm.write {
            realm.add(newSites)
            realm.add(newCategoria)
        }
        
        return newSites
    }
    
    
    private func removeAllLocalSites() {
        let realm = try! Realm()
        try? realm.write {
            realm.delete(realm.objects(SitoWebCategoria.self))
            realm.delete(realm.objects(SitoWeb.self))
        }
    }
}
