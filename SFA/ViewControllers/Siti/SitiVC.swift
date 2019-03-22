//
//  SitiListVC.swift
//  SFA
//
//  Created by Dani Tox on 22/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import SafariServices

class SitiVC: UITableViewController {
    
    var dataSource : SitiDataSource
    var themeObserver : NSObjectProtocol?
    
    init(type: WebsiteType) {
        self.dataSource = SitiDataSource(type: type)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.errorHandler = { errStr in
            self.showError(withTitle: "Errore", andMessage: errStr) //already in mainqueue
        }
        
        themeObserver = NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main, using: { (notification) in
            UIView.animate(withDuration: 0.3, animations: { self.updateTheme() })
        })
        
        
        tableRefreshControl.addTarget(self, action: #selector(refreshPulled), for: .valueChanged)
        tableView.refreshControl = tableRefreshControl
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = Theme.current.tableViewBackground
        tableView.register(SitoCell.self, forCellReuseIdentifier: "sitoCell")
        tableView.dataSource = self.dataSource
        
        dataSource.fetchData {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    @objc private func refreshPulled() {
        tableView.refreshControl?.beginRefreshing()
        dataSource.fetchSitesFromNetwork {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    private func updateTheme() {
        tableView.backgroundColor = Theme.current.tableViewBackground
        tableView.reloadData()
    }
}

extension SitiVC {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sito = dataSource.getSiteFrom(indexPath)
        if let url = sito?.url {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true, completion: nil)
        }
    }
}
