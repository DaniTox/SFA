//
//  VerificaCompagniaDataSource.swift
//  SFA
//
//  Created by Dani Tox on 16/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

//struct CategoriaObject {
//    var categoria : CompagniaCategoria
//    var domande : [CompagniaDomanda]
//}

class VerificaCompagniaDataSource : NSObject, UITableViewDataSource {
    
    private var domandeFile: CompagniaDomandeFile
    private var risposteFile: CompagniaRisposteFile
    
    private var model : CompagniaAgent
        
    init(scuolaType: ScuolaType) {
        self.model = CompagniaAgent()
        self.domandeFile = CompagniaDomandeFile.get(for: scuolaType)!
        self.risposteFile = CompagniaRisposteFile.get(for: scuolaType)
    }
    
    func getCategoria(at index: Int) -> CompagniaDomandeFile.CompagniaCategoriaFile {
        return domandeFile.categorie[index]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return domandeFile.categorie[section].domande.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return domandeFile.categorie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CompagniaDomandaCell
        cell?.accessoryType = .none
        
        let domanda = self.domandeFile.categorie[indexPath.section].domande[indexPath.row]
        cell?.domanda = domanda
        
        if let risposta = self.risposteFile.risposte[domanda.id] {
            cell?.risposta = risposta
        }
        
        cell?.layoutIfNeeded()
        cell?.updateConstraintsIfNeeded()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.domandeFile.categorie[section].name        
    }
    
}
