//
//  NotificheVC.swift
//  SFA
//
//  Created by Dani Tox on 21/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit
import UserNotifications

class NotificheOnBoardingVC : NotificheVC {
 
    lazy var doneButton : UIBouncyButton = {
        let button = UIBouncyButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline).withSize(25)
        button.setTitle("Fine", for: .normal)
        button.backgroundColor = UIColor.darkGray.darker()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(doneButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        doneButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: tableView.frame.height / 8).isActive = true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableHeight = tableView.frame.height
        let cellHeight = tableHeight / CGFloat(notifiche.count + 2)
        return cellHeight
    }

}

class NotificheVC: UITableViewController {
    
    fileprivate let notifiche : [String] = ["Eventi MGS",
                                        "Consigli di Don Bosco",
                                        "Promemoria sacramenti",
                                        "Mssione dell'angelo custode"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notifiche"
        tableView.allowsMultipleSelection = true
        tableView.backgroundColor = UIColor.black.lighter(by: 10)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        requestNotificationAccess()
    }
    
    private func requestNotificationAccess() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound, .badge, .alert]) { (granted, error) in
            if error != nil {
                print(error!)
                return
            }
            
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Non hai permesso le notifiche... Fanculo")
            }
        }
    }
    
}

extension NotificheVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifiche.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let notifica = notifiche[indexPath.row]
        cell?.textLabel?.text = notifica
        cell?.textLabel?.textColor = .white
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        cell?.backgroundColor = .clear
        
        cell?.selectionStyle = .none
        if notificheDaRicevere.contains(notifica) {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notifica = notifiche[indexPath.row]
        if notificheDaRicevere.contains(notifica) {
            notificheDaRicevere.removeAll(where: {$0 == notifica})
        } else {
            notificheDaRicevere.append(notifica)
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableHeight = tableView.frame.height
        let cellHeight = tableHeight / CGFloat(notifiche.count + 1)
        return cellHeight
    }
}

