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
    
    var sitesCategories : [SitoWebCategoria] = []
    
    public func fetchLocalWebsites() -> [SitoWebCategoria]  {
        let realm = try! Realm()
        return realm.objects(SitoWebCategoria.self).map { $0 }
    }
    
    public func loadSites(type: WebsiteType, completion: (([SitoWebCategoria]) -> Void)? = nil) {
        self.getWebsites(type: type) { (sites) in
            let coreDataSites = self.createCoreDataObjects(sites)
            completion?(coreDataSites)
        }
    }
    
    private func createCoreDataObjects(_ objects: [SitoCategoriaObject]) -> [SitoWebCategoria] {
        self.removeAllLocalSites()
        var siti : [SitoWebCategoria] = []
        
        for categoria in objects {
            let categoriaCD = SitoWebCategoria(context: context)
            categoriaCD.name = categoria.nome
            categoriaCD.idOrder = Int16(categoria.idOrder)
            categoriaCD.descrizione = categoria.descrizione
            
            for sito in categoria.sites {
                let sitoCD = SitoWeb(context: context)
                sitoCD.nome = sito.nome
                sitoCD.descrizione = sito.descrizione
                sitoCD.idOrder = Int16(sito.idOrder)
                sitoCD.url = URL(string: sito.url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) ?? "")
                categoriaCD.addToSitiWeb(sitoCD)
            }
            siti.append(categoriaCD)
        }
        return siti
    }
    
    
    private func removeAllLocalSites() {
        let realm = try! Realm()
        try? realm.write {
            realm.delete(realm.objects(SitoWebCategoria.self))
        }
    }
}
