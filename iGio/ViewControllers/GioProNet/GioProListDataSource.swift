//
//  GioProListDataSource.swift
//  MGS
//
//  Created by Dani Tox on 05/05/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import RealmSwift

class GioProListDataSource: NSObject, UITableViewDataSource, DZNEmptyDataSetSource {
    
    var errorHandler: ((String) -> Void)?
    var dataLoaded: (() -> Void)?
    
    var model: GioProNetAgent = GioProNetAgent()
    var weeks : [GioProNetWeek] = []
    
    func fetchEntries() {
        self.weeks = model.getThemAll().map { $0 }
        self.dataLoaded?()
    }
    
    func getEntry(at indexPath: IndexPath) -> GioProNet {
        return weeks[indexPath.section].tables[indexPath.row]
    }
    
    func getWeek(at index: Int) -> GioProNetWeek {
        return self.weeks[index]
    }
    
    func remove(table: GioProNet) {
        let realm = try! Realm()
        try? realm.write {
            realm.delete(table)
        }
        self.weeks.first(where: { $0.tables.contains(table) })?.tables.removeAll(where: { $0 == table })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.weeks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weeks[section].tables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as! GioProListCell
        let item = self.weeks[indexPath.section].tables[indexPath.row]
        cell.gioItem = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = self.getEntry(at: indexPath)
            self.remove(table: entry)
            
            if self.weeks[indexPath.section].tables.count == 0 {
                self.weeks.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "GioProNet"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Non hai ancora aggiunto nessun dato.\nCreane uno premendo sul pulsante +"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
}
