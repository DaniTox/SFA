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
    
    private var modelJson : CompagniaFile {
        guard let url = Bundle.main.url(forResource: "compagnie", withExtension: "json") else { fatalError() }
        guard let data = try? Data(contentsOf: url) else { fatalError() }
        guard let object = try? JSONDecoder().decode(CompagniaFile.self, from: data) else { fatalError() }
        return object
    }
    
    public func createIfNotPresent() {
        let realm = try! Realm()
        
        //ottengo tutte le regole nel database (dovrebbe sempre e solo essercene una)
        let verifiche = realm.objects(VerificaCompagnia.self)
        //se non ce n'è neanche una, la creo al momento dal file json
        if verifiche.count < 1 {
            print("Creating CompagniaTest since it doesn't exist")
            _ = self.createCompagniaBaseEntry()
        } else {
            print("CompagniaTest esiste già. Non la creo in CoreData")
        }
    }
    
    private func createCompagniaBaseEntry() -> VerificaCompagnia {
        let realm = try! Realm()
        
        //ottengo il file padre
        let model = self.modelJson
        
        //creo una verifica vuota in CoreData
        let verifica = VerificaCompagnia()
        
        //per ogni categoria che c'è nel file, la creo in CoreData e la aggiungo alla verifica in CoreData
        for categoria in model.categorie {
            let cdCategoria = VerificaCategoria()
            cdCategoria.name = categoria.nome
            
            //per ogni domanda nel file, creo una domanda CoreData e la aggiungo alla categoria CoreData
            for domandaString in categoria.domande {
                let cdDomanda = VerificaDomanda()
                cdDomanda.domanda = domandaString
                
                cdCategoria.domande.append(cdDomanda)
            }
            
            //qua aggiungo la categoria alla verifica come detto in precedenza
            verifica.categorie.append(cdCategoria)
        }
        
        //salvo il context per applicare le modifiche
        try? realm.write {
            realm.add(verifica)
        }
        
        //ritorno la verifica in caso di necessità
        return verifica
    }
    
    //attualmente, i piani alti dicono che esiste solo una verifica. quindi usare questa funzione per ottenere l'unica verifica da CoreData
    public func getLatestVerifica() -> VerificaCompagnia {
        let realm = try! Realm()
        
        let verifiche = realm.objects(VerificaCompagnia.self)
        
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
