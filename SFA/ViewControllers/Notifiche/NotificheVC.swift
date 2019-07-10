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
        
        self.view.backgroundColor = Theme.current.tableViewBackground
        
        tableView.allowsMultipleSelection = true
        tableView.backgroundColor = Theme.current.tableViewBackground
        tableView.register(BoldCell.self, forCellReuseIdentifier: "boldCell")
        tableView.register(SwitchCell.self, forCellReuseIdentifier: "switchCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        dataSource.controller = self
        dataSource.tableView = self.tableView
        tableView.dataSource = dataSource
        tableView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Notifiche.updateStatus()
    }
    
}

extension NotificheVC {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            if !Notifiche.areNotificheActive { break }
            
            let notifica = dataSource.notifiche[indexPath.row]
            if Notifiche.activeNotifiche.contains(notifica) {
                Notifiche.activeNotifiche.remove(notifica)
            } else {
                Notifiche.activeNotifiche.insert(notifica)
            }
            
            Notifiche.updateStatus()
            tableView.reloadData()
        default: break
        }
    }
    
}
