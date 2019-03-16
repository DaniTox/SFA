//
//  TeenStarListVC.swift
//  SFA
//
//  Created by Dani Tox on 02/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import RealmSwift

class TeenStarListVC<T: TeenStarDerivative & Object>: UITableViewController, DZNEmptyDataSetDelegate {

    var themeObserver : NSObjectProtocol!
    
    var dataSource : TeenStarListSource<T>
    init() {
        self.dataSource = TeenStarListSource()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Storico"
        themeObserver = NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main, using: { (notification) in
            UIView.animate(withDuration: 0.3, animations: { self.updateTheme() })
        })
        
        dataSource.errorHandler = { [weak self] (errorString) in
            self?.showError(withTitle: "Errore", andMessage: errorString) //already in MainQueue
        }
        
        dataSource.dataLoaded = { [weak self] in
            self?.tableView.reloadData()
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(tableViewWasPulled), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Theme.current.tableViewBackground
        tableView.register(BoldCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = dataSource
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEntryButtonTapped))
        navigationItem.setRightBarButton(rightButton, animated: true)
    }

    deinit {
        NotificationCenter.default.removeObserver(themeObserver)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.fetchEntries()
    }
    
    private func updateTheme() {
        tableView.backgroundColor = Theme.current.tableViewBackground
        tableView.reloadData()
    }
    
    @objc private func tableViewWasPulled() {
        dataSource.fetchEntries()
    }
    
    @objc private func addEntryButtonTapped() {
        if dataSource.isTodayTableEmpty {
            let entry = dataSource.createNewTable()
            let vc = TeenStarEditEntryVC<T>(table: entry)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            self.showError(withTitle: "Attenzione", andMessage: "Puoi inserire solo un dato al giorno. Riprova domani.")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = dataSource.getEntry(at: indexPath.row)
        let vc = TeenStarEditEntryVC<T>(table: entry)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = dataSource.getEntry(at: indexPath.row)
            dataSource.remove(table: entry)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
