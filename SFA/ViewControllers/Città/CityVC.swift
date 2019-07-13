//
//  CityVC.swift
//  MGS
//
//  Created by Dani Tox on 17/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class CityVC: UITableViewController {
    
    var dataSource = CityDataSource()
    var cRefreshControl : UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Città"
        
        dataSource.tableView = tableView
        
        cRefreshControl.addTarget(self, action: #selector(refreshed), for: .valueChanged)
        tableView.refreshControl = cRefreshControl
        
        tableView.separatorStyle = .none
        tableView.dataSource = dataSource
        tableView.backgroundColor = Theme.current.tableViewBackground
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(LocationCell.self, forCellReuseIdentifier: "locCell")
        tableView.register(BoldCell.self, forCellReuseIdentifier: "boldCell")
        
        dataSource.errorHandler = self.errorHandler
        dataSource.updateHandler = self.updateOccurred
        
        dataSource.load()
    }
    
    func errorHandler(err: Error) {
        self.showError(withTitle: "Errore", andMessage: "\(err.localizedDescription)")
    }
    
    @objc private func refreshed() {
        self.cRefreshControl.beginRefreshing()
        dataSource.load()
    }
    
    func updateOccurred() {
        DispatchQueue.main.async {
            self.cRefreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
}

extension CityVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = dataSource.allCities[indexPath.row]
        
        if city.isSelected {
            self.dataSource.agent.removeSites(for: city)
            self.dataSource.agent.toggle(city: city)
            self.dataSource.reloadFromLocal()
        } else {
            self.dataSource.loadingCities.append(city)
            
            dataSource.agent.fetchLocalizedWebsites(for: city) { listResult in
                switch listResult {
                case .success(let list):
                    print("\n\nINIZIO\n")
                    for site in list.siti {
                        print(site.urlString)
                    }
                    print("\nFINEEE\n\n")
                    
                    self.dataSource.loadingCities.removeAll { $0 == city }
                    self.dataSource.agent.toggle(city: city)
                    
                    self.dataSource.reloadFromLocal()
                
                case .failure(let err):
                    self.errorHandler(err: err)
                }
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
