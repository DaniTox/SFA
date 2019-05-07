//
//  DebugVC.swift
//  MGS
//
//  Created by Dani Tox on 09/04/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class DebugVC : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Debug"
        self.view.backgroundColor = Theme.current.tableViewBackground
        
        self.tableView.separatorStyle = .none   
        self.tableView.register(BoldCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BoldCell
        switch indexPath.row {
        case 0:
            cell.mainLabel.text = "Resetta Regola di Vita"
        case 1:
            cell.mainLabel.text = "Resetta TeenStar"
        case 2:
            cell.mainLabel.text = "Resetta 'Il mio percorso formativo'"
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let realm = try! Realm()
            try? realm.write {
                realm.delete(realm.objects(RegolaVita.self))
                realm.delete(realm.objects(RegolaCategoria.self))
                realm.delete(realm.objects(RegolaDomanda.self))
            }
            self.showError(withTitle: "Completato", andMessage: "La regola di vita è stata resettata")
        case 1:
            let realm = try! Realm()
            try? realm.write {
                realm.delete(realm.objects(TeenStarMaschio.self))
                realm.delete(realm.objects(TeenStarFemmina.self))
            }
            self.showError(withTitle: "Completato", andMessage: "TeenSTAR è stato resettato")
        case 2:
            let agent = CompagniaAgent()
            agent.removeAll()
            agent.createIfNotPresent()
            
            self.showError(withTitle: "Completato", andMessage: "Percorso formativo resettato")
        default:
            break
        }
    }
}
