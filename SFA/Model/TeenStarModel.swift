//
//  TeenStarModel.swift
//  SFA
//
//  Created by Dani Tox on 02/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import RealmSwift

class TeenStarModel<T: TeenStarDerivative & Object> {
    var errorHandler : ((String)->Void)?
    
    public func isTodayTableEmpty() -> Bool {
        let realm = try! Realm()
        
        var calendar = Calendar.current
        calendar.locale = NSLocale.current
        
        let dateFrom = calendar.startOfDay(for: Date())
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)!
        
        let fromPredicate = NSPredicate(format: "date > %@", dateFrom as NSDate)
        let toPredicate = NSPredicate(format: "date < %@", dateTo as NSDate)
        let fullPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        
        let tables = realm.objects(T.self).filter(fullPredicate)
        return tables.count == 0
        
    }
    
    public func fetchEntries() -> Results<T> {
        let realm = try! Realm()
        let entries = realm.objects(T.self).sorted(byKeyPath: "date", ascending: false)
        return entries
    }
    
    public func getNewEntry() -> T {
        let newEntry = T()
        return newEntry
    }
    
}
