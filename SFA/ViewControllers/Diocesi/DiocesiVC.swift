//
//  DiocesiVC.swift
//  MGS
//
//  Created by Dani Tox on 17/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class DiocesiVC: UITableViewController {
    
    var dataSource = DiocesiDataSource()
    var cRefreshControl : UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Diocesi"
        
        cRefreshControl.addTarget(self, action: #selector(refreshed), for: .valueChanged)
        tableView.refreshControl = cRefreshControl
        
        tableView.dataSource = dataSource
        tableView.backgroundColor = Theme.current.tableViewBackground
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        dataSource.errorHandler = self.errorHandler
        dataSource.updateHandler = self.updateOccurred
        
        dataSource.load()
    }
    
    func errorHandler(err: Error) {
        self.showError(withTitle: "Errore", andMessage: "\(err)")
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

extension DiocesiVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
