//
//  NoteListVC.swift
//  SFA
//
//  Created by Dani Tox on 27/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class NoteListVC: UITableViewController {
    
    let dataSource = NotesDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pagine"
        
        dataSource.errorHandler = { [weak self] (error) in
            self?.showError(withTitle: "Errore", andMessage: "\(error)") //already in MainQueue
        }
        
        dataSource.dataLoaded = { [weak self] in
            self?.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = Theme.current.tableViewBackground
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        tableView.register(BoldCell.self, forCellReuseIdentifier: "cell")
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(tablePulled), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        navigationItem.setRightBarButton(addButton, animated: true)
        
        if UIDevice.current.deviceType == .pad {
            let dismissButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissMe))
            navigationItem.setLeftBarButton(dismissButton, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.updateData()
    }
    
    @objc private func tablePulled() {
        dataSource.updateData()
    }
    
    @objc private func addButtonPressed() {
        let note = dataSource.getNewNote()

        if let splitVC = self.splitViewController {
            let vc = NoteVC(nota: note)
            let nav = ThemedNavigationController(rootViewController: vc)
            splitVC.showDetailViewController(nav, sender: self)
        } else {
            let vc = NoteVC(nota: note)
            navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    @objc private func dismissMe() {
        if let splitViewController = self.splitViewController {
            splitViewController.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension NoteListVC : DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = dataSource.getNoteAt(indexPath: indexPath)

        if let splitVC = self.splitViewController {
            let vc = NoteVC(nota: note)
            let nav = ThemedNavigationController(rootViewController: vc)
            splitVC.showDetailViewController(nav, sender: self)
        } else {
            let vc = NoteVC(nota: note)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Diario"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Non hai ancora aggiunto nessuna pagina di diario."
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        return NSAttributedString(string: "Crea")
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        addButtonPressed()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    
}
