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

    enum RegoleFileNames: String, CaseIterable {
        case medie = "regolaMedie"
        case biennio = "regolaBiennio"
        case triennio = "regolaTriennio"
    }
    
    static let shared = RegolaFetcherModel()
    private init() { }
    
    func createIfNotPresent() {
        let realm = try! Realm()
        for type in ScuolaType.allCases {
            let allRegole = realm.objects(RegolaVita.self).filter(NSPredicate(format: "scuolaTypeID == %d", type.rawValue))
            if allRegole.count < 1 {
                var fileName: RegoleFileNames
                switch type {
                case .medie:
                    fileName = .medie
                case .biennio:
                    fileName = .biennio
                case .triennio:
                    fileName = .triennio
                }
                createRegolaModel(fileName: fileName.rawValue)
            }
        }
    }

    public func createRegolaModel(fileName: String) {
        let path = Bundle.main.path(forResource: fileName, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let regolaFile = try! JSONDecoder().decode(RegolaFile.self, from: data)
        
        let newRegola = RegolaVita.createFromFile(regolaFile: regolaFile)
        let realm = try! Realm()
        try? realm.write {
            realm.add(newRegola)
        }
    }
    
    private func getLatestRegola(type: ScuolaType) throws -> RegolaVita {
        let realm = try! Realm()
        let regole = realm.objects(RegolaVita.self).filter(NSPredicate(format: "scuolaTypeID == %d", type.rawValue))
        if let regola = regole.first {
            return regola
        } else {
            throw ToxException.genericError("Errore regola database. Contatta lo sviluppatore")
        }
    }
    
    public func getRegola(type: ScuolaType) -> RegolaVita? {
        return try? self.getLatestRegola(type: type)
    }

}
