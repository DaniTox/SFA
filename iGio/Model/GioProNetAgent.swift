//
//  GioProNetAgent.swift
//  MGS
//
//  Created by Dani Tox on 05/05/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import RealmSwift

class GioProNetAgent {
    public var errorHandler : ((String)->Void)?
    
    public static var isTodayAvailable: Bool {
        return GioProNetAgent.isDateAvailable(Date())
    }
    
    static func isDateAvailable(for item: GioProNet) -> Bool {
        let realm = try! Realm()
        let calendar = Calendar.current
        
        let dateFrom = calendar.startOfDay(for: item.date)
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)!
        
        let fromPredicate = NSPredicate(format: "date >= %@", dateFrom as NSDate)
        let toPredicate = NSPredicate(format: "date < %@", dateTo as NSDate)
        let fullPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        
        let objects = realm.objects(GioProNet.self).filter(fullPredicate)
        if objects.contains(item) {
            return true
        } else {
            return objects.count == 0
        }
        
    }
    
   static func isDateAvailable(_ date: Date) -> Bool {
        let realm = try! Realm()
        let calendar = Calendar.current
        
        let dateFrom = calendar.startOfDay(for: date)
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)!
        
        let fromPredicate = NSPredicate(format: "date >= %@", dateFrom as NSDate)
        let toPredicate = NSPredicate(format: "date < %@", dateTo as NSDate)
        let fullPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        
        let objects = realm.objects(GioProNet.self).filter(fullPredicate)
        return objects.count == 0
    }
    
    
    func getThemAll() -> [GioProNetWeek] {
        let realm = try! Realm()
        let allDates = realm.objects(GioProNet.self).map { $0.date }
        
        var weeks: Set<GioProNetWeek> = []
        
        for date in allDates {
            let newWeek = GioProNetWeek(startOfWeek: date.startOfWeek!)
            weeks.insert(newWeek)
        }
        
        for week in weeks {
            var calendar = Calendar.current
            calendar.locale = NSLocale.current
            
            let dateFrom = calendar.startOfDay(for: week.startOfWeek)
            let dateTo = dateFrom.endOfWeek!
            
            let fromPredicate = NSPredicate(format: "date >= %@", dateFrom as NSDate)
            let toPredicate = NSPredicate(format: "date < %@", dateTo as NSDate)
            let fullPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
            
            week.tables = realm.objects(GioProNet.self).filter(fullPredicate).map { $0 }.sorted(by: { $0.date > $1.date })
        }
        
        return weeks.sorted(by: { $0.startOfWeek > $1.startOfWeek })
    }
    
    
    public func fetchEntries() -> Results<GioProNet> {
        let realm = try! Realm()
        let entries = realm.objects(GioProNet.self).sorted(byKeyPath: "date", ascending: false)
        return entries
    }
    
    public func getNewEntry() -> GioProNet {
        return GioProNet()
    }
    
}
