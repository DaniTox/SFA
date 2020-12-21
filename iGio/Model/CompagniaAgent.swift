//
//  CompagniaTestModel.swift
//  SFA
//
//  Created by Dani Tox on 05/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

//Compagnia è il vecchio nome per Percorso Formativo
class CompagniaAgent {
    
    enum VerificaFileNames: String, CaseIterable {
        case medie = "verificaMedie"
        case biennio = "verificaBiennio"
        case triennio = "verificaTriennio"
    }
    
    func getFileName(for type: ScuolaType) -> String {
        switch type {
        case .medie: return "verificaMedie"
        case .biennio: return "verificaBiennio"
        case .triennio: return "verificaTriennio"
        }
    }
    
    public func convertRealmToJSON() {
        let realm = try! Realm()
        
        let urls = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        guard let appURL = urls.first?.appendingPathComponent("Verifica") else { return }
        
        for type in ScuolaType.allCases {
            let allRegole = realm.objects(VerificaCompagnia.self).filter(NSPredicate(format: "scuolaTypeID == %d", type.rawValue))
            if allRegole.isEmpty { continue }
            guard let firstRegola = allRegole.first else { continue }
            
            let fileName = getFileName(for: type)
            guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else { continue }
            guard let data = try? Data(contentsOf: fileURL) else { continue }
            guard let verificaFile = try? JSONDecoder().decode(CompagniaDomandeFile.self, from: data) else { continue }
            
            let risposteFile = CompagniaRisposteFile()
            
            for (indexCat, cat) in verificaFile.categorie.enumerated() {
                for (indexDom, _) in cat.domande.enumerated() {
                    let domandaID = verificaFile.categorie[indexCat].domande[indexDom].id
                    risposteFile.risposte[domandaID] = firstRegola.categorie[indexCat].domande[indexDom].risposta
                }
            }
            
            let newURL = appURL.appendingPathComponent("risposte_\(fileName).json")
            guard let json = try? JSONEncoder().encode(risposteFile) else { continue }
            try? FileManager.default.createDirectory(atPath: newURL.deletingLastPathComponent().path,
                                                     withIntermediateDirectories: true,
                                                     attributes: nil)
            
            try? json.write(to: newURL)
        }
    }
    
    public func removeAll() {
        let realm = try! Realm()
        let allObjects = realm.objects(VerificaCompagnia.self)
        try? realm.write {
            realm.delete(allObjects)
        }
    }

}

class CompagniaDomandeFile : Codable {
    var schoolType: ScuolaType
    var categorie : [CompagniaCategoriaFile] = []
    init(scuolaType: ScuolaType) { self.schoolType = scuolaType }
    
    class CompagniaCategoriaFile : Codable {
        var id: UUID
        var name : String
        var domande : [CompagniaDomanda]
    }

    class CompagniaDomanda: Codable {
        var id: UUID
        var str: String
    }
    
    static func get(for type: ScuolaType) -> CompagniaDomandeFile? {
        let model = CompagniaAgent()
        guard let url = Bundle.main.url(forResource: model.getFileName(for: type), withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(CompagniaDomandeFile.self, from: data)
    }
}

class CompagniaRisposteFile: Codable {
    var risposte: [UUID : Int] = [:]
    
    static func get(for type: ScuolaType) -> CompagniaRisposteFile {
        let url = FileManager.getVerificaDirectory(for: type)
        
        guard let data = try? Data(contentsOf: url) else { return CompagniaRisposteFile() }
        guard let obj = try? JSONDecoder().decode(CompagniaRisposteFile.self, from: data) else { return CompagniaRisposteFile() }
        return obj
    }
    
    func save(for type: ScuolaType) {
        let url = FileManager.getVerificaDirectory(for: type)
        guard let data = try? JSONEncoder().encode(self) else { return }
        try? data.write(to: url)
    }
}
