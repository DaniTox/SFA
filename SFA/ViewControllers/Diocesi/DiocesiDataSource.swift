//
//  DiocesiDataSource.swift
//  MGS
//
//  Created by Dani Tox on 17/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class DiocesiDataSource: NSObject, UITableViewDataSource {
    
    var allDiocesi: [Diocesi] = [] {
        didSet {
            if allDiocesi.isEmpty { return }
            self.updateHandler?()
        }
    }
    var updateHandler: (() -> Void)? = nil
    var errorHandler: ((Error) -> Void)? = nil {
        didSet {
            self.agent.errorHandler = self.errorHandler
        }
    }

    var agent: SiteLocalizer = SiteLocalizer()
    
    
    func load() {
        allDiocesi.removeAll(keepingCapacity: true)
        agent.getDiocesi(saveRecords: true) { _ in
            DispatchQueue.main.async {
                let realm = try! Realm()
                self.allDiocesi = realm.objects(Diocesi.self).map { $0 }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allDiocesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boldCell") as! BoldCell
        let diocesi = allDiocesi[indexPath.row]
        cell.backgroundColor = Theme.current.backgroundColor
        cell.mainLabel.text = diocesi.name
        return cell
    }
    
}
