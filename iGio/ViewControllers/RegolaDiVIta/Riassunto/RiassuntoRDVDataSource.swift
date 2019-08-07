//
//  RiassuntoRDVDataSource.swift
//  MGS
//
//  Created by Dani Tox on 09/04/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class RiassuntoDataSource : NSObject, UITableViewDataSource {
    struct DomandaIndex {
        var categoriaIndex: Int
        var domandaIndex: Int
    }
    
    private var regola: RegolaVita?
    private var domande : [RegolaDomanda] = []
    
    private let categoriesIndexes : [DomandaIndex] = [
        .init(categoriaIndex: 0, domandaIndex: 4),
        .init(categoriaIndex: 1, domandaIndex: 9),
        .init(categoriaIndex: 2, domandaIndex: 12),
        .init(categoriaIndex: 3, domandaIndex: 15),
        .init(categoriaIndex: 4, domandaIndex: 18),
        .init(categoriaIndex: 5, domandaIndex: 21)
    ]
    
    init(regolaType: ScuolaType) {
        super.init()
        self.regola = RegolaFetcherModel.shared.getRegola(type: regolaType)
        
        let realm = try! Realm()
        for indice in self.categoriesIndexes {
            let predicate = NSPredicate(format: "order == %d", indice.domandaIndex)
            let typePredicate = NSPredicate(format: "ANY categoria.regola.scuolaTypeID == %d", regolaType.rawValue)
            let fullPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, typePredicate])
            domande.append(contentsOf: realm.objects(RegolaDomanda.self).filter(fullPredicate).map { $0 })
        }
    }
    
    func getDomanda(at index: Int) -> RegolaDomanda? {
        return self.domande[index]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return domande.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BoldCell
        let domanda = domande[indexPath.section]
        cell.mainLabel.numberOfLines = 0
        
        switch indexPath.row {
        case 0:
            cell.mainLabel.text = "\(domanda.domanda)"
        case 1:
            cell.mainLabel.numberOfLines = 0
            cell.mainLabel.textColor = UIColor.lightGray
            cell.mainLabel.text = "\(domanda.risposta ?? "Nessuna risposta")"
        default:
            break
        }
        
        return cell
    }
    
}
