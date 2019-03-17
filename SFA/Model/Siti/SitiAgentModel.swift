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
        let realm = try! Realm()
        
        var siti : [SitoWebCategoria] = []
        
        for categoria in objects {
            let categoriaCD = SitoWebCategoria()
            categoriaCD.nome = categoria.nome
            categoriaCD.order = categoria.idOrder
            categoriaCD.descrizione = categoria.descrizione ?? ""
            
            for sito in categoria.sites {
                let sitoCD = SitoWeb()
                sitoCD.nome = sito.nome
                sitoCD.descrizione = sito.descrizione ?? ""
                sitoCD.order = sito.idOrder
                if let webUrlString = sito.urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed),
                    let url = URL(string: webUrlString) {
                    sitoCD.url = url
                }
                categoriaCD.siti.append(sitoCD)
            }
            siti.append(categoriaCD)
        }
        
        try? realm.write {
            realm.add(siti)
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
