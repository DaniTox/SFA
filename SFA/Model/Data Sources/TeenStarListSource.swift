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

class TeenStarListSource<T : TeenStarDerivative & Object> : NSObject, UITableViewDataSource, DZNEmptyDataSetSource {

    var errorHandler : ((String) -> Void)? {
        didSet {
            self.model.errorHandler = errorHandler
        }
    }
    var model : TeenStarModel<T>
    var entries : [T] = []
    
    var dataLoaded : (() -> Void)?
    
    override init() {
        self.model = TeenStarModel()
        super.init()
    }
    
    var isTodayTableEmpty : Bool {
        return model.isTodayTableEmpty()
    }
    
    func createNewTable() -> T {
        return model.getNewEntry()
    }
    
    func fetchEntries() {
        self.entries = model.fetchEntries().map { $0 }
        dataLoaded?()
    }
    
    func getEntry(at index: Int) -> T {
        return entries[index]
    }
    
    func remove(table: T) {
        let realm = try! Realm()
        try? realm.write {
            realm.delete(table)
        }
        self.entries.removeAll(where: { $0 == table })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TeenStarCell
        let entry = entries[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        cell.mainLabel.text = "\(entry.date.dayOfWeek()) - \(entry.date.stringValue)"
        
        if let sentimentiTable = entry.sentimentiTable {
            cell.setSentimenti(table: sentimentiTable)
        }
        
        return cell
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
