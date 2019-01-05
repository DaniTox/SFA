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
    
    private var modelJson : CompagniaFile? {
        guard let url = Bundle.main.url(forResource: "compagnie", withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        guard let object = try? JSONDecoder().decode(CompagniaFile.self, from: data) else { return nil }
        return object
    }
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    public func createIfNotPresent() {
        let context = persistentContainer.viewContext
        
        let request : NSFetchRequest<Regola> = Regola.fetchRequest()
        let regole = try? context.fetch(request)
        guard let unRegole = regole else { return }
        if unRegole.count < 1 {
            print("Creating CompagniaTest since it doesn't exist")
            _ = self.createCompagniaBaseEntry()
        } else {
            print("CompagniaTest esiste già. Non la creo in CoreData")
        }
    }
    
    private func createCompagniaBaseEntry() -> CompagniaTest {
        //ottengo il file padre
        guard let model = self.modelJson else { fatalError("Error compagnia base entry creation") }
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
        
        //ritorno la verifica in caso di necessità
        return verifica
    }
    
    //attualmente, i piani alti dicono che esiste solo una verifica. quindi usare questa funzione per ottenere l'unica verifica da CoreData
    public func getLatestVerifica() -> CompagniaTest {
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<CompagniaTest> = CompagniaTest.fetchRequest()
        
        guard let verifiche = try? context.fetch(request) else {
            //se non riesco a prendere le verifiche salvate, ne creo una vuota dal file json e uso qella
            return self.createCompagniaBaseEntry()
        }
        
        guard let firstVerifica = verifiche.first else {
            //se non riesco a prendere le verifiche salvate, ne creo una vuota dal file json e uso qella
            return self.createCompagniaBaseEntry()
        }
        
        return firstVerifica
    }
}

class CompagniaFile : Codable {
    var categorie : [CompagniaCategoriaFile]
}

class CompagniaCategoriaFile : Codable {
    var nome : String
    var domande : [String]
}
