//
//  CityDataSource.swift
//  MGS
//
//  Created by Dani Tox on 17/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class CityDataSource: NSObject, UITableViewDataSource {
    
    var allCities: [CityCodable] = [] {
        didSet {
            if allCities.isEmpty { return }
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
        allCities.removeAll(keepingCapacity: true)
        agent.getCitta(saveRecords: true) { codableCities in
            self.allCities = codableCities
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locCell") as! LocationCell
        let diocesi = allCities[indexPath.row]
        cell.backgroundColor = Theme.current.backgroundColor
        cell.mainLabel.text = diocesi.name
        return cell
    }
    
}
