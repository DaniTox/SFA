//
//  TeenStarGridDataSource.swift
//  MGS
//
//  Created by Daniel Fortesque on 24/03/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class TeenStarGridDataSource<T : TeenStarDerivative & Object> : NSObject, UITableViewDataSource, DZNEmptyDataSetSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TeenStarGridCell
        
        let entry = entries[indexPath.row]
        
        cell.mainLabel.text = "\(entry.date.dayOfWeek()) - \(entry.date.stringValue)"
        
        if let sentimentiTable = entry.sentimentiTable {
            cell.setSentimenti(table: sentimentiTable)
        }
        
        
        return cell
    }
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

