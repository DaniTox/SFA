//
//  SitiListVC.swift
//  SFA
//
//  Created by Dani Tox on 22/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class SitiListVC : UIViewController, HasCustomView {
    typealias CustomView = SitiListView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var dataSource : SitiDataSource!
    
    var themeObserver : NSObjectProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer else {
            fatalError()
        }
        self.dataSource = SitiDataSource(container: persistentContainer)
        
        themeObserver = NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main, using: { (notification) in
            UIView.animate(withDuration: 0.3, animations: { self.updateTheme() })
        })
        
        rootView.tableView.register(SitoCell.self, forCellReuseIdentifier: "sitoCell")
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self.dataSource
        
        dataSource.updateData = { [weak self] in
            DispatchQueue.main.async {
                self?.rootView.tableView.reloadData()
            }
        }
    }
    
    private func updateTheme() {
        rootView.tableView.backgroundColor = Theme.current.tableViewBackground
        rootView.tableView.reloadData()
    }
}

extension SitiListVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
