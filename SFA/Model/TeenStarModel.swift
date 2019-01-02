//
//  TeenStarModel.swift
//  SFA
//
//  Created by Dani Tox on 02/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import CoreData

class TeenStarModel {
    
    var persistentContainer : NSPersistentContainer
    var errorHandler : ((String)->Void)?
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    //this is just a primitive function. Don't call this directly. Call todayTableIsEmpty instead.
    private func primitive_TodayTableIsEmpty() throws -> Bool {
        let request : NSFetchRequest<TeenStarTable> = TeenStarTable.fetchRequest()
        
        var calendar = Calendar.current
        calendar.locale = NSLocale.current
        
        let dateFrom = calendar.startOfDay(for: Date())
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        if dateTo == nil {
            throw ToxError.noteRelated("Errore mentre esguivo qualche controllo delle date. Riprova a creare la nota domani (dalle 00:00 in poi)")
        }
        
        let fromPredicate = NSPredicate(format: "date > %@", dateFrom as NSDate)
        let toPredicate = NSPredicate(format: "date < %@", dateTo! as NSDate)
        let fullPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        request.predicate = fullPredicate
        
        let context = persistentContainer.viewContext
        var tablesEntries : [TeenStarTable]
        do {
            tablesEntries = try context.fetch(request)
        } catch {
            throw error
        }
        
        if tablesEntries.count == 0 {
            return true
        } else {
            return false
        }
    }
    
    public func todayTableIsEmpty() -> Bool {
        do {
            return try self.primitive_TodayTableIsEmpty()
        } catch {
            self.errorHandler?("\(error)")
            return false
        }
    }
    
    public func fetchEntries() -> [TeenStarTable] {
        let request : NSFetchRequest<TeenStarTable> = TeenStarTable.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        let context = persistentContainer.viewContext
        var entries : [TeenStarTable] = []
        do {
            entries = try context.fetch(request)
        } catch {
            errorHandler?("\(error)")
        }
        
        return entries
    }
    
}
