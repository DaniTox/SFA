//
//  VerificaCompagniaDataSource.swift
//  SFA
//
//  Created by Dani Tox on 16/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

struct CategoriaObject {
    var categoria : CompagniaCategoria
    var domande : [CompagniaDomanda]
}

class VerificaCompagniaDataSource : NSObject, UITableViewDataSource {
    
    public var verifica : CompagniaTest!
    private let model : CompagniaTestModel!
    
    private var storage : [CategoriaObject] = []
    
    override init() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Delegate error")
        }
        let persistentContainer = delegate.persistentContainer
        self.model = CompagniaTestModel(container: persistentContainer)
        self.verifica = model.getLatestVerifica()
        
        let categorie = model.getCategorieFrom(verifica: self.verifica)
        for categoria in categorie {
            let object = CategoriaObject(categoria: categoria, domande: model.getDomandaFrom(categoria: categoria))
            storage.append(object)
        }
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
        guard let categorie = self.verifica.categorie as? Set<CompagniaCategoria> else { return nil }
        let categorieArray = Array(categorie)
        return categorieArray[section].name
    }
    
}
