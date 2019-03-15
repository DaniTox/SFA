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
    
    public var verifica : VerificaCompagnia
    private let model : CompagniaAgent!
    
    private var storage = List<VerificaCategoria>()
    
    override init() {
        self.model = CompagniaAgent()
        self.verifica = model.getLatestVerifica()
        
        self.storage = self.verifica.categorie
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage[section].domande.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return storage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CompagniaDomandaCell
        cell?.accessoryType = .none
        let domanda = storage[indexPath.section].domande[indexPath.row]
        cell?.domanda = domanda
        cell?.layoutIfNeeded()
        cell?.updateConstraintsIfNeeded()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let categorie = self.verifica.categorie
        return categorie[section].name
    }
    
}
