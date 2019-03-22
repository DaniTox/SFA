//
//  SitiListVC.swift
//  SFA
//
//  Created by Dani Tox on 22/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import SafariServices

class SitiVC: UIViewController, HasCustomView {
    typealias CustomView = SitiListView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var dataSource : SitiDataSource
    var themeObserver : NSObjectProtocol?
    
    init(type: WebsiteType) {
        self.dataSource = SitiDataSource(type: type)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.errorHandler = { errStr in
            self.showError(withTitle: "Errore", andMessage: errStr) //already in mainqueue
        }
        
        themeObserver = NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main, using: { (notification) in
            UIView.animate(withDuration: 0.3, animations: { self.updateTheme() })
        })
        
        rootView.refreshControl.addTarget(self, action: #selector(refreshPulled), for: .valueChanged)
        
        rootView.tableView.register(SitoCell.self, forCellReuseIdentifier: "sitoCell")
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self.dataSource
        
//        dataSource.databaseUpdated = { [weak self] in
//            if self?.dataSource.sites.count == 0 {
//                self?.dataSource.fetchSitesFromNetwork()
//            } else {
//                DispatchQueue.main.async {
//                    self?.rootView.tableView.reloadData()
//                    self?.rootView.refreshControl.endRefreshing()
//                }
//            }
//        }
        
//        dataSource.networkSitesUpdated = { [weak self] in
//            DispatchQueue.main.async {
//                self?.rootView.tableView.reloadData()
//                self?.rootView.refreshControl.endRefreshing()
//            }
//        }
        
        dataSource.fetchData {
            DispatchQueue.main.async { [weak self] in
                self?.rootView.tableView.reloadData()
                self?.rootView.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc private func refreshPulled() {
        rootView.refreshControl.beginRefreshing()
        dataSource.fetchSitesFromNetwork {
            DispatchQueue.main.async { [weak self] in
                self?.rootView.tableView.reloadData()
                self?.rootView.refreshControl.endRefreshing()
            }
        }
    }
    
    private func updateTheme() {
        rootView.tableView.backgroundColor = Theme.current.tableViewBackground
        rootView.tableView.reloadData()
    }
}

extension SitiVC : UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sito = dataSource.getSiteFrom(indexPath)
        if let url = sito?.url {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true, completion: nil)
        }
    }
}
