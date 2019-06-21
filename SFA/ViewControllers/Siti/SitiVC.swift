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
    
    init(types: [SitoCategoria]) {
        self.dataSource = SitiDataSource(categorie: types)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeObserver = NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main, using: { (notification) in
            UIView.animate(withDuration: 0.3, animations: { self.updateTheme() })
        })
        
        dataSource.errorHandler = self.errorOccurred
        
        tableRefreshControl.addTarget(self, action: #selector(refreshPulled), for: .valueChanged)
        tableView.refreshControl = tableRefreshControl
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = Theme.current.tableViewBackground
        tableView.register(SitoCell.self, forCellReuseIdentifier: "sitoCell")
        tableView.dataSource = self.dataSource
        
        dataSource.updateHandler = self.updateOccurred
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshPulled))
        self.navigationItem.setRightBarButton(refreshButton, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.fetchLocalWebsistes()
    }
    
    func updateOccurred() {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    @objc private func refreshPulled() {
        dataSource.updateFromServer()
        tableView.refreshControl?.beginRefreshing()
    }
    
    private func updateTheme() {
        tableView.backgroundColor = Theme.current.tableViewBackground
        tableView.reloadData()
    }
    
    private func errorOccurred(err: Error) {
        DispatchQueue.main.async {
            self.tableRefreshControl.endRefreshing()
        }
        
        self.showError(withTitle: "Errore", andMessage: "\(err)")
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
