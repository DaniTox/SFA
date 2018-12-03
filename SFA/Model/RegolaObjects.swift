//
//  RegolaDiVita.swift
//  SFA
//
//  Created by Dani Tox on 25/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation
import CoreData


class Regola : NSManagedObject {
    static func createFromFileObject(object: RegolaFile, context: NSManagedObjectContext) -> Regola {
        let regolaCD = Regola(context: context)
        for (index, categoriaFile) in object.categories.enumerated() {
            let categoriaCD = Categoria(context: context)
            categoriaCD.regola = regolaCD
            categoriaCD.id = Int16(index)
            categoriaCD.name = categoriaFile.name
            
            for (index, domandaFile) in categoriaFile.domande.enumerated() {
                let domandaCD = Domanda(context: context)
                domandaCD.categoria = categoriaCD
                domandaCD.id = Int16(index)
                domandaCD.domanda = domandaFile.domanda
                domandaCD.risposta = domandaFile.rispsota
            }
            
        }
        do {
            try context.save()
        } catch {
            print("errore saving context: \(error)")
        }
        
        return regolaCD
    }
}

class Categoria : NSManagedObject {
}

class Domanda : NSManagedObject {
}

