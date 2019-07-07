//
//  NotificheVC.swift
//  SFA
//
//  Created by Dani Tox on 21/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit
import UserNotifications

class NotificheVC: UITableViewController {
    
    let dataSource = NotificheDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notifiche"
        
        tableView.allowsMultipleSelection = true
        tableView.backgroundColor = UIColor.black.lighter(by: 10)
        tableView.register(SwitchCell.self, forCellReuseIdentifier: "switchCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        dataSource.tableView = self.tableView
        tableView.dataSource = dataSource
        tableView.delegate = self
        
    }
    
    
}

extension NotificheVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            if !dataSource.areNotificheAllowed { break }
            
            let notifica = dataSource.notifiche[indexPath.row]
            if Notifiche.activeNotifiche.contains(notifica) {
                Notifiche.activeNotifiche.remove(notifica)
            } else {
                Notifiche.activeNotifiche.insert(notifica)
            }
            
            tableView.reloadData()
        default: break
        }
    }
    
}
