//
//  CompagniaTestModel.swift
//  SFA
//
//  Created by Dani Tox on 05/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import CoreData

class CompagniaTestModel {
    
    var persistentContainer : NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    func createIfNotPresent() {
        let context = persistentContainer.viewContext
        
        let request : NSFetchRequest<Regola> = Regola.fetchRequest()
        let regole = try? context.fetch(request)
        guard let unRegole = regole else { return }
        if unRegole.count < 1 {
            print("Creating CompagniaTest since it doesn't exist")
            self.createCompagniaBaseEntry()
        } else {
            print("CompagniaTest esiste già. Non la creo in CoreData")
        }
    }
    
    private var modelJson : CompagniaFile? {
        guard let url = Bundle.main.url(forResource: "compagnie", withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        guard let object = try? JSONDecoder().decode(CompagniaFile.self, from: data) else { return nil }
        return object
    }
    
    public func createCompagniaBaseEntry() {
        //ottengo il file padre
        guard let model = self.modelJson else { print("Error compagnia base entry creation"); return }
        let context = persistentContainer.viewContext
        
        //creo una verifica vuota in CoreData
        let verifica = CompagniaTest(context: context)
        
        //per ogni categoria che c'è nel file, la creo in CoreData e la aggiungo alla verifica in CoreData
        for categoria in model.categorie {
            let cdCategoria : CompagniaCategoria = CompagniaCategoria(context: context)
            cdCategoria.name = categoria.nome
            
            //per ogni domanda nel file, creo una domanda CoreData e la aggiungo alla categoria CoreData
            for domandaString in categoria.domande {
                let cdDomanda : CompagniaDomanda = CompagniaDomanda(context: context)
                cdDomanda.domanda = domandaString
                
                cdCategoria.addToDomande(cdDomanda)
            }
            
            //qua aggiungo la categoria alla verifica come detto in precedenza
            verifica.addToCategorie(cdCategoria)
        }
        
        //salvo il context per applicare le modifiche
        try? context.save()
    }
}

class CompagniaFile : Codable {
    var categorie : [CompagniaCategoriaFile]
}

class CompagniaCategoriaFile : Codable {
    var nome : String
    var domande : [String]
}
