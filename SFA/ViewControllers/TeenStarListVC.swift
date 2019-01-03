//
//  TeenStarListVC.swift
//  SFA
//
//  Created by Dani Tox on 02/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class TeenStarListVC: UIViewController, HasCustomView {
    typealias CustomView = TeenStarListView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var model : TeenStarModel!
    var entries : [TeenStarTable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Storico"
        
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        model = TeenStarModel(container: persistentContainer)
        model.errorHandler = { [weak self] (errorString) in
            self?.showError(withTitle: "Errore", andMessage: errorString) //already in MainQueue
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(tableViewWasPulled), for: .valueChanged)
        rootView.tableView.refreshControl = refreshControl
        rootView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEntryButtonTapped))
        navigationItem.setRightBarButton(rightButton, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchEntries()
    }
    
    @objc private func tableViewWasPulled() {
        fetchEntries()
    }
    
    @objc private func addEntryButtonTapped() {
        if model.todayTableIsEmpty() {
            let vc = TeenStarEditEntryVC()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            self.showError(withTitle: "Attenzione", andMessage: "I dati di oggi sono già stati inseriti. Se devi modificarli, premi il primo risultato.")
        }
    }
    
    private func fetchEntries() {
        self.entries = model.fetchEntries()
        rootView.tableView.reloadData()
    }
    
}

extension TeenStarListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let entry = entries[indexPath.row]
        cell?.textLabel?.text = "\(entry.date?.stringValue ?? "NULL")"
        return cell!
    }
    
    //TODO: da completare l'implementazione
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TeenStarEditEntryVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}
