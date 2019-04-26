//
//  CompagniaTestModel.swift
//  SFA
//
//  Created by Dani Tox on 05/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class CompagniaAgent {
    
    enum VerificaFileNames: String, CaseIterable {
        case medie = "verificaMedie"
        case biennio = "verificaBiennio"
        case triennio = "verificaTriennio"
    }
    
    public func createIfNotPresent() {
        let realm = try! Realm()
        
        for type in ScuolaType.allCases {
            let allRegole = realm.objects(VerificaCompagnia.self).filter(NSPredicate(format: "scuolaTypeID == %d", type.rawValue))
            if allRegole.count < 1 {
                var fileName: VerificaFileNames
                switch type {
                case .medie:
                    fileName = .medie
                case .biennio:
                    fileName = .biennio
                case .triennio:
                    fileName = .triennio
                }
                createCompagniaModel(fileName: fileName.rawValue)
            }
        }

    }
    
    private func createCompagniaModel(fileName: String) {
        let path = Bundle.main.path(forResource: fileName, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let compagniaFile = try! JSONDecoder().decode(CompagniaFile.self, from: data)
        
        let newCompagnia = VerificaCompagnia.create(from: compagniaFile)
        let realm = try! Realm()
        try? realm.write {
            realm.add(newCompagnia)
        }
    }
    

    public func getLatestVerifica(of type: ScuolaType) -> VerificaCompagnia? {
        let realm = try! Realm()
        
        let verifiche = realm.objects(VerificaCompagnia.self).filter(NSPredicate(format: "scuolaTypeID == %d", type.rawValue))
        if let verifica = verifiche.first {
            return verifica
        } else {
            print("Errore verifica database")
        }
        return nil
    }
    
}

class CompagniaFile : Codable {
    var scuolaType: ScuolaType
    var categorie : [CompagniaCategoriaFile] = []
    init(scuolaType: ScuolaType) { self.scuolaType = scuolaType }
}

class CompagniaCategoriaFile : Codable {
    var nome : String
    var domande : [String]
}
