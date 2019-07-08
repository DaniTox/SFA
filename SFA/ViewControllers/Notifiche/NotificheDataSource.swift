//
//  NotificheDataSource.swift
//  MGS
//
//  Created by Dani Tox on 07/07/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class NotificheDataSource: NSObject, UITableViewDataSource {
    
    var tableView: UITableView!
    var notifiche = Notifiche.NotificheType.allCases
    var areNotificheAllowed: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return notifiche.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0: return makeSwitchCell(in: tableView)
        case 1:
            let notifica = self.notifiche[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "boldCell") as! BoldCell

            cell.mainLabel.text = notifiche[indexPath.row].stringValue
            cell.mainLabel.textColor = areNotificheAllowed ? Theme.current.textColor : .gray
            
            cell.accessoryType = Notifiche.activeNotifiche.contains(notifica) ? .checkmark : .none
            
            return cell
        default: fatalError()
        }
        
    }
    
    func makeSwitchCell(in tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchCell
        cell.mainLabel.text = "Attiva le notifiche"
        cell.accessoryType = .none
        cell.cellSwitch.isOn = self.areNotificheAllowed
        cell.cellSwitch.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        return cell
    }
    
    @objc private func switchChanged(_ sender: UISwitch) {
        self.areNotificheAllowed = sender.isOn
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return nil
        case 1: return "Seleziona le categorie"
        default: return nil
        }
    }
    
}

