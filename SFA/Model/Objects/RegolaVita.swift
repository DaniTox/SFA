//
//  RegolaVita.swift
//  SFA
//
//  Created by Dani Tox on 08/03/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import RealmSwift

class RegolaVita : Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var dateOfModification = Date()
    let categorie = List<RegolaCategoria>()
    
    static func createFromFile(regolaFile: RegolaFile) -> RegolaVita {
        let regolaCD = RegolaVita()
        for categoriaFile in regolaFile.categories {
            let categoriaCD = RegolaCategoria()
            regolaCD.categorie.append(categoriaCD)
            categoriaCD.nome = categoriaFile.name
            categoriaCD.order = categoriaFile.id
            
            for domandaFile in categoriaFile.domande {
                let domandaCD = RegolaDomanda()
                categoriaCD.domande.append(domandaCD)
                domandaCD.domanda = domandaFile.domanda
                domandaCD.risposta = domandaFile.rispsota
                domandaCD.order = domandaFile.idDomanda
            }
        }
        return regolaCD
    }
}

class RegolaCategoria : Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var order = 0
    @objc dynamic var nome = ""
    
    let domande = List<RegolaDomanda>()
    let regola = LinkingObjects(fromType: RegolaVita.self, property: "categorie")
}

class RegolaDomanda : Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var order = 0
    @objc dynamic var domanda = ""
    @objc dynamic var risposta : String?
    let categoria = LinkingObjects(fromType: RegolaCategoria.self, property: "domande")
}
