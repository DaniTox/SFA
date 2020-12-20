//
//  VerificaCompagnia.swift
//  SFA
//
//  Created by Dani Tox on 15/03/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import RealmSwift

class VerificaCompagnia : Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var scuolaTypeID = 0
    let categorie = List<VerificaCategoria>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    var scuolaType: ScuolaType {
        get {
            return ScuolaType(rawValue: scuolaTypeID)!
        } set {
            self.scuolaTypeID = newValue.rawValue
        }
    }
    
//    static func create(from file: CompagniaDomandeFile) -> VerificaCompagnia {
//        //creo una verifica vuota in CoreData
//        let verifica = VerificaCompagnia()
//        verifica.scuolaType = file.scuolaType
//        
//        //per ogni categoria che c'è nel file, la creo in CoreData e la aggiungo alla verifica in CoreData
//        for categoria in file.categorie {
//            let cdCategoria = VerificaCategoria()
//            cdCategoria.name = categoria.name
//            
//            //per ogni domanda nel file, creo una domanda CoreData e la aggiungo alla categoria CoreData
//            for domandaString in categoria.domande {
//                let cdDomanda = VerificaDomanda()
//                cdDomanda.domanda = domandaString
//                
//                cdCategoria.domande.append(cdDomanda)
//            }
//            
//            //qua aggiungo la categoria alla verifica come detto in precedenza
//            verifica.categorie.append(cdCategoria)
//        }
//        
//        return verifica
//    }
}

class VerificaCategoria : Object {
    @objc dynamic var name = ""
    let verifica = LinkingObjects(fromType: VerificaCompagnia.self, property: "categorie")
    let domande = List<VerificaDomanda>()
}

class VerificaDomanda : Object {
    @objc dynamic var domanda = ""
    @objc dynamic var risposta = 0
    let categoria = LinkingObjects(fromType: VerificaCategoria.self, property: "domande")
    
}


