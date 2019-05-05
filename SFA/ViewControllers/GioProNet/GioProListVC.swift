//
//  GioProListVC.swift
//  MGS
//
//  Created by Dani Tox on 05/05/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class GioProListVC : UITableViewController, DZNEmptyDataSetDelegate {
    
    var dataSource = GioProListDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Storico"
        
        dataSource.errorHandler = { [weak self] (errorString) in
            self?.showError(withTitle: "Errore", andMessage: errorString) //already in MainQueue
        }
        
        dataSource.dataLoaded = { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(tableViewWasPulled), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = Theme.current.tableViewBackground
        tableView.register(TeenStarMaschioCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TeenStarListFemminaCell.self, forCellReuseIdentifier: "femaleCell")
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = dataSource
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEntryButtonTapped))
        navigationItem.setRightBarButton(rightButton, animated: true)
    }
    
    @objc private func tableViewWasPulled() {
        dataSource.fetchEntries()
    }
    
    @objc private func addEntryButtonTapped() {
        let vc = GioProEditorVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = dataSource.getEntry(at: indexPath)
        let vc = GioProEditorVC(taskTable: entry)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderView()
        let week = dataSource.getWeek(at: section)
        let now = Date()
        let endDate = week.startOfWeek
        
        let components = Calendar.current.dateComponents([.weekOfYear], from: endDate, to: now)
        if components.weekOfYear ?? 0 == 0 {
            view.mainLabel.text = "Questa settimana"
        } else if components.weekOfYear ?? 0 == 1 {
            view.mainLabel.text = "1 settimana fa"
        } else {
            view.mainLabel.text = "\(components.weekOfYear ?? 0) settimane fa"
        }
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
}
