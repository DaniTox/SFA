//
//  VerificaCompagniaDataSource.swift
//  SFA
//
//  Created by Dani Tox on 16/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class VerificaCompagniaDataSource : NSObject, UITableViewDataSource {
    
    public var verifica : CompagniaTest!
    private let model : CompagniaTestModel!
    
    private var storage : [CompagniaCategoria : [CompagniaDomanda]] = [:]
//    private var selectedCategoria : CompagniaCategoria!
    
    override init() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Delegate error")
        }
        let persistentContainer = delegate.persistentContainer
        self.model = CompagniaTestModel(container: persistentContainer)
        self.verifica = model.getLatestVerifica()
        
        guard let verificaCategorie = self.verifica.categorie as? Set<CompagniaCategoria> else {
            fatalError()
        }
     
        let categorieArray = Array(verificaCategorie).sorted(by: { ($0.name ?? "") < ($1.name ?? "") })
        
        for categoria in categorieArray {
            guard let domandeSet = categoria.domande as? Set<CompagniaDomanda> else { fatalError() }
            let domandeArray = Array(domandeSet).sorted(by: { ($0.domanda ?? "") < ($1.domanda ?? "") })
            storage[categoria] = domandeArray
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.keys.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.verifica.categorie?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CompagniaDomandaCell
        let categoria = Array(storage.keys)[indexPath.section]
//        guard indexPath.row < (storage[categoria]?.count ?? 0) else {
//            fatalError()
//        }
        if let domanda = storage[categoria]?[indexPath.row] {
            cell?.domanda = domanda
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let categorie = self.verifica.categorie as? Set<CompagniaCategoria> else { return nil }
        let categorieArray = Array(categorie)
        return categorieArray[section].name
    }
}
