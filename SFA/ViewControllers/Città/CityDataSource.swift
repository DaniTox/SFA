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
    
    var tableView: UITableView?
    var loadingCities: [CityCodable] = [] {
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
        allCities.removeAll(keepingCapacity: true)
        agent.getCitta(saveRecords: true) { codableCities in
            self.allCities = self.agent.updateFromLocal(cities: codableCities)
        }
    }
    
    func reloadFromLocal() {
        self.allCities = agent.fetchLocalCities()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locCell") as! LocationCell
        let city = allCities[indexPath.row]
        cell.backgroundColor = Theme.current.backgroundColor
        cell.mainLabel.text = city.name
        
        if city.isSelected {
            cell.accessoryType = .checkmark
            cell.loadingIndicator.stopAnimating()
        } else {
            if self.loadingCities.contains(city) {
                cell.loadingIndicator.startAnimating()
            } else {
                cell.loadingIndicator.stopAnimating()
            }
            cell.accessoryType = .none
        }
        
        
        return cell
    }
    
}
