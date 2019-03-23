//
//  SitiAgentModel.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import RealmSwift

class SitiAgent : NetworkAgent<SitiNetworkResponse> {
    
    var sites : [SitoWeb] = []
    
    public func fetchLocalWebsites(type: WebsiteType) -> [SitoWeb]  {
        let realm = try! Realm()
        switch type {
        case .materiali:
            let predicate = NSPredicate(format: "ANY categoria.idCategoriaType == %d", WebsiteType.materiali.rawValue)
            return realm.objects(SitoWeb.self).filter(predicate).map { $0 }
        case .preghiere:
            let predicate = NSPredicate(format: "ANY categoria.idCategoriaType == %d", WebsiteType.preghiere.rawValue)
            return realm.objects(SitoWeb.self).filter(predicate).map { $0 }
        }
    }
    
    func fetchFromNetwork(type: WebsiteType, completion: (() -> Void)? = nil) {
        if type == .materiali {
            let request = SitiMaterialiRequest()
            self.executeNetworkRequest(with: request) { (response) in
                DispatchQueue.main.async {
                    self.convertAndSave(siti: response.siti, for: response.categoria)
                    completion?()
                }
            }
        } else {
            let request = SitiPreghiereRequest()
            self.executeNetworkRequest(with: request) { (response) in
                DispatchQueue.main.async {
                    self.convertAndSave(siti: response.siti, for: response.categoria)
                    completion?()
                }
            }
        }
    }
    
    private func convertAndSave(siti: [SitoObject], for categoria: SitoCategoriaObject) {
        let realm = try! Realm()
        
        let categorieToRemove = realm.objects(SitoWebCategoria.self).filter(NSPredicate(format: "idCategoriaType == %d", categoria.id ?? -1))
        let sitiToRemove = realm.objects(SitoWeb.self).filter(NSPredicate(format: "ANY self.categoria.idCategoriaType == %d", categoria.id ?? -1))
        
        try? realm.write {
            realm.delete(categorieToRemove)
            realm.delete(sitiToRemove)
        }
        
        let newCategoria = SitoWebCategoria()
        newCategoria.idCategoriaType = categoria.id ?? -1
        newCategoria.nome = categoria.nome
        newCategoria.descrizione = categoria.descrizione ?? ""
        newCategoria.order = categoria.order ?? -1
        
        var newSites: [SitoWeb] = []
        
        for sito in siti {
            let newSito = SitoWeb()
            newSito.nome = sito.nome
            newSito.descrizione = sito.descrizione ?? ""
            newSito.order = sito.order ?? 0
            newSito.url = URL(string: sito.urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) ?? "")
            
            newSites.append(newSito)
        }
        
        newCategoria.siti.append(objectsIn: newSites)
        
        try? realm.write {
            realm.add(newSites)
            realm.add(newCategoria)
        }
    }
    
    
    private func removeAllLocalSites() {
        let realm = try! Realm()
        try? realm.write {
            realm.delete(realm.objects(SitoWebCategoria.self))
            realm.delete(realm.objects(SitoWeb.self))
        }
    }
}
