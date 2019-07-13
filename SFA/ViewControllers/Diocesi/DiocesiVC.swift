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
        self.title = "Provincia"
        
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

extension DiocesiVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let diocesi = dataSource.allDiocesi[indexPath.row]
        
        if diocesi.isSelected {
            
            self.dataSource.agent.removeSites(for: diocesi)
            self.dataSource.agent.toggle(diocesi: diocesi)
            self.dataSource.reloadFromLocal()
            
        } else {
            self.dataSource.loadingDiocesi.append(diocesi)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
            
            
            dataSource.agent.fetchLocalizedWebsites(for: diocesi) { (list) in
                
                self.dataSource.loadingDiocesi.removeAll { $0 == diocesi }
                self.dataSource.agent.toggle(diocesi: diocesi)
                
                self.dataSource.reloadFromLocal()

            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
