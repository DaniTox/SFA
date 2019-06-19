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
        
        cRefreshControl.addTarget(self, action: #selector(refreshed), for: .valueChanged)
        tableView.refreshControl = cRefreshControl
        
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
