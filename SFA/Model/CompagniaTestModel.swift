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
    
    private var modelJson : CompagniaFile {
        guard let url = Bundle.main.url(forResource: "compagnie", withExtension: "json") else { fatalError() }
        guard let data = try? Data(contentsOf: url) else { fatalError() }
        guard let object = try? JSONDecoder().decode(CompagniaFile.self, from: data) else { fatalError() }
        return object
    }
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    public func createIfNotPresent() {
        let context = persistentContainer.viewContext
        
        //ottengo tutte le regole nel database (dovrebbe sempre e solo essercene una)
        let request : NSFetchRequest<Regola> = Regola.fetchRequest()
        let regole = try? context.fetch(request)
        guard let unRegole = regole else { return }
        //se non ce n'è neanche una, la creo al momento dal file json
        if unRegole.count < 1 {
            print("Creating CompagniaTest since it doesn't exist")
            _ = self.createCompagniaBaseEntry()
        } else {
            print("CompagniaTest esiste già. Non la creo in CoreData")
        }
    }
    
    private func createCompagniaBaseEntry() -> CompagniaTest {
        //ottengo il file padre
        let model = self.modelJson
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
    
    public func getCategorieFrom(verifica: CompagniaTest) -> [CompagniaCategoria] {
        //ottengo le categorie direttamente dall'oggetto invece che da una CoreData request
        guard let categorieSet = verifica.categorie as? Set<CompagniaCategoria> else { return [] }
        let array = Array(categorieSet).sorted(by: { ($0.name ?? "") > ($1.name ?? "") })
        return array
    }
    
    public func getDomandaFrom(categoria: CompagniaCategoria) -> [CompagniaDomanda] {
        //ottengo le domande direttamente dall'oggetto invece che da una CoreData request
        guard let domandeSet = categoria.domande as? Set<CompagniaDomanda> else { return [] }
        let array = Array(domandeSet).sorted(by: { ($0.domanda ?? "") > ($1.domanda ?? "")})
        return array
    }
}

class CompagniaFile : Codable {
    var categorie : [CompagniaCategoriaFile]
}

class CompagniaCategoriaFile : Codable {
    var nome : String
    var domande : [String]
}
