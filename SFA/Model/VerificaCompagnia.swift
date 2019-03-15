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
    let categorie = List<VerificaCategoria>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
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


