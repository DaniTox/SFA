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

class TeenStarWeek<T: TeenStarDerivative & Object> : Hashable {
    static func == (lhs: TeenStarWeek<T>, rhs: TeenStarWeek<T>) -> Bool {
        return lhs.startOfWeek == rhs.startOfWeek //&& lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(startOfWeek)
//        hasher.combine(id)
    }
    
    var id: UUID = UUID()
    var startOfWeek: Date
    var tables : [T]
    
    init(startOfWeek : Date) {
        self.startOfWeek = startOfWeek
        self.tables = []
    }
    
}

class TeenStarListSource<T : TeenStarDerivative & Object> : NSObject, UITableViewDataSource, DZNEmptyDataSetSource {
    var entryType: TeenStarType
    
    var errorHandler : ((String) -> Void)? {
        didSet {
            self.model.errorHandler = errorHandler
        }
    }
    var model : TeenStarModel<T>
    var weeks : [TeenStarWeek<T>] = []
    
    var dataLoaded : (() -> Void)?
    
    init(type: TeenStarType) {
        self.entryType = type
        self.model = TeenStarModel()
        super.init()
    }
    
    func fetchEntries() {
        self.weeks = model.getThemAll().map { $0 }
        dataLoaded?()
    }
    
    func getEntry(at indexPath: IndexPath) -> T {
        return weeks[indexPath.section].tables[indexPath.row]
    }
    
    func getWeek(at index: Int) -> TeenStarWeek<T> {
        return self.weeks[index]
    }
    
    func remove(table: T) {
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
        if self.entryType == .femmina {
            let cell = tableView.dequeueReusableCell(withIdentifier: "femaleCell") as! TeenStarListFemminaCell
            let entry = self.weeks[indexPath.section].tables[indexPath.row] as! TeenStarFemmina
            cell.accessoryType = .disclosureIndicator
            
            cell.dateLabel.text = "\(entry.date.dayOfWeek()) - \(entry.date.stringValue)"
            
            if let cicloTable = entry.cicloTable {
                cell.set(color: cicloTable.cicloColor)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TeenStarMaschioCell
            let entry = self.weeks[indexPath.section].tables[indexPath.row] as! TeenStarMaschio
            cell.accessoryType = .disclosureIndicator
            
            cell.mainLabel.text = "\(entry.date.dayOfWeek()) - \(entry.date.stringValue)"
            
            if let sentimentiTable = entry.sentimentiTable {
                cell.setSentimenti(table: sentimentiTable)
            }
            
            return cell
        }
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
