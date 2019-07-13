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
    
    var allDiocesi: [DiocesiCodable] = [] {
        didSet {
            if allDiocesi.isEmpty { return }
            self.updateHandler?()
        }
    }
    
    var tableView: UITableView?
    var loadingDiocesi: [DiocesiCodable] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
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
        agent.getDiocesi(saveRecords: true) { diocesiCodable in
            self.allDiocesi = self.agent.updateFromLocal(diocesis: diocesiCodable)
        }
    }
    
    func reloadFromLocal() {
        self.allDiocesi =  agent.fetchLocalDiocesi()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allDiocesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locCell") as! LocationCell
        let diocesi = allDiocesi[indexPath.row]
//        cell.containerView.backgroundColor = Theme.current.backgroundColor
        cell.mainLabel.text = diocesi.name
        
        if diocesi.isSelected {
            cell.accessoryType = .checkmark
            cell.loadingIndicator.stopAnimating()
        } else {
            if self.loadingDiocesi.contains(diocesi) {
                cell.loadingIndicator.startAnimating()
            } else {
                cell.loadingIndicator.stopAnimating()
            }
            cell.accessoryType = .none
        }
        
        return cell
    }
    
}
