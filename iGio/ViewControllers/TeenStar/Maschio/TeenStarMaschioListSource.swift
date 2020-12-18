//
//  TeenStarListSource.swift
//  SFA
//
//  Created by Dani Tox on 16/03/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift
import DZNEmptyDataSet

class TeenStarMaschioListSource: NSObject, UITableViewDataSource, DZNEmptyDataSetSource {
    
    var errorHandler : ((String) -> Void)? {
        didSet {
            self.model.errorHandler = errorHandler
        }
    }
    var model : TeenStarModel<TeenStarMaschio>
    var weeks : [TeenStarWeek<TeenStarMaschio>] = []
    
    var dataLoaded : (() -> Void)?
    
    override init() {
        self.model = TeenStarModel()
        super.init()
    }
    
    func fetchEntries() {
        self.weeks = model.getThemAll().map { $0 }
        dataLoaded?()
    }
    
    func getEntry(at indexPath: IndexPath) -> TeenStarMaschio {
        return weeks[indexPath.section].tables[indexPath.row]
    }
    
    func getWeek(at index: Int) -> TeenStarWeek<TeenStarMaschio> {
        return self.weeks[index]
    }
    
    func remove(table: TeenStarMaschio) {
        let realm = try! Realm()
        try? realm.write {
            realm.delete(table)
        }
        self.weeks.first(where: { $0.tables.contains(table) })?.tables.removeAll(where: { $0 == table })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weeks[section].tables.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.weeks.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TeenStarMaschioCell
            let entry = self.weeks[indexPath.section].tables[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            
            cell.mainLabel.text = "\(entry.date.dayOfWeek()) - \(entry.date.stringValue)"
            
            if let sentimentiTable = entry.sentimentiTable {
                cell.setSentimenti(table: sentimentiTable)
            }
            
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
