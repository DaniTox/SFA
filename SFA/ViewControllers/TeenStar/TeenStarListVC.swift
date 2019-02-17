//
//  TeenStarListVC.swift
//  SFA
//
//  Created by Dani Tox on 02/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class TeenStarListVC: UIViewController, HasCustomView {
    typealias CustomView = TeenStarListView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var model : TeenStarModel!
    var entries : [TeenStarTable] = []
    
    var themeObserver : NSObjectProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Storico"
        themeObserver = NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main, using: { (notification) in
            UIView.animate(withDuration: 0.3, animations: { self.updateTheme() })
        })
        
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        model = TeenStarModel(container: persistentContainer)
        model.errorHandler = { [weak self] (errorString) in
            self?.showError(withTitle: "Errore", andMessage: errorString) //already in MainQueue
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(tableViewWasPulled), for: .valueChanged)
        rootView.tableView.refreshControl = refreshControl
        rootView.tableView.register(BoldCell.self, forCellReuseIdentifier: "cell")
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.emptyDataSetDelegate = self
        rootView.tableView.emptyDataSetSource = self
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEntryButtonTapped))
        navigationItem.setRightBarButton(rightButton, animated: true)
    }

    deinit {
        NotificationCenter.default.removeObserver(themeObserver)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchEntries()
    }
    
    private func updateTheme() {
        rootView.tableView.backgroundColor = Theme.current.tableViewBackground
        rootView.tableView.reloadData()
    }
    
    @objc private func tableViewWasPulled() {
        fetchEntries()
    }
    
    @objc private func addEntryButtonTapped() {
        if model.todayTableIsEmpty() {
            let entry = model.getNewEntry()
            let vc = TeenStarEditEntryVC()
            
            vc.genderType = userLogged?.gender ?? .boy
            vc.entry = entry
            
            navigationController?.pushViewController(vc, animated: true)
        } else {
            self.showError(withTitle: "Attenzione", andMessage: "Puoi inserire solo un dato al giorno. Riprova domani.")
        }
    }
    
    private func fetchEntries() {
        self.entries = model.fetchEntries()
        rootView.tableView.reloadData()
    }
    
}

extension TeenStarListVC : UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BoldCell
        let entry = entries[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.mainLabel.text = "\(entry.date?.dayOfWeek() ?? "NULL") - \(entry.date?.stringValue ?? "NULL")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TeenStarEditEntryVC()
        let entry = entries[indexPath.row]
        vc.entry = entry
        vc.genderType = userLogged?.gender ?? .boy
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = entries[indexPath.row]
            let context = entry.managedObjectContext
            context?.delete(entry)
            if let _ = try? context?.save() {
                entries.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "TeenSTAR"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Non hai ancora aggiunto nessun dato.\nCreane uno premendo sul pulsante +"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
}
