//
//  TSFAgent.swift
//  MGS
//
//  Created by Dani Tox on 26/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import RealmSwift

class TSFAgent {
    
    /// Ritorna un range di date che rappresentano i giorni del mese (tutti i giorni del mese) prendendolo dalla data passata come arg
    /// - Parameter date: la data da cui prendere il mese.
    /// - Returns range: il range con tutti i giorni del mese
    func getMonthRange(from date: Date) -> ClosedRange<Date> {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        guard let startOfMonth = calendar.date(from: components) else {
            return Date()...Date()
        }
        
        var componentsToAdd = DateComponents()
        componentsToAdd.month = 1
        componentsToAdd.day = -1
        
        guard let finishDate = calendar.date(byAdding: componentsToAdd, to: startOfMonth)
            else {
                return Date()...Date()
        }
        
        return startOfMonth...finishDate
    }
    
    public func getMonthRangeCollection(from date: Date) -> [Date] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        guard let startOfMonth = calendar.date(from: components) else {
            return []
        }
        
        var componentsToAdd = DateComponents()
        componentsToAdd.month = 1
        componentsToAdd.day = -1
        
        guard let finishDate = calendar.date(byAdding: componentsToAdd, to: startOfMonth)
            else {
                return []
        }
        
        // Formatter for printing the date, adjust it according to your needs:
        let fmt = DateFormatter()
        fmt.dateFormat = "dd/MM/yyyy"

        var tempDate = startOfMonth
        var buffer = [Date]()
        
        while tempDate <= finishDate {
            print(fmt.string(from: tempDate))
            buffer.append(tempDate)
            tempDate = calendar.date(byAdding: .day, value: 1, to: tempDate)!
        }
        
        return buffer
    }
    
    /// Ritorna la data del item TS Femmina più lontano nel passato
    public func getFarestDate() -> Date {
        let realm = try! Realm()
        let obj = realm.objects(TeenStarFemmina.self).sorted(byKeyPath: "date", ascending: true).first
        return obj?.date ?? Date()
    }
    
    ///Ottiene la lista degli anni a partire dall'argomento passato fino a quest'anno
    /// - L'argomento passato deve avere l'anno <= dell'anno attuale
    public func getYearsList(basedOn date: Date) -> [Int] {
        let calendar = Calendar.current
        
        let lowerDate = calendar.component(.year, from: date)
        let thisYear = calendar.component(.year, from: Date())

        return Array(lowerDate...thisYear)
    }
    
    ///Ottiene la lista dei mesi dell'anno passato come arg.
    /// - Se è un anno futuro, ritorna un array vuoto
    /// - Se è uguale all'anno attuale, ritorna tutti i mesi fino a quello attuale
    /// - Se è minore di quello attuale, ritorna tutti i mesi dell'anno
    public func getMonthsList(for year: Int) -> [Int] {
        let calendar = Calendar.current
        
        let thisYear = calendar.component(.year, from: Date())
        if year > thisYear {
            return []
        }
        if year < thisYear {
            return Array(1...12)
        }
        if year == thisYear {
            let thisMonth = calendar.component(.month, from: Date())
            return Array(0...thisMonth)
        }
        return []
    }
    
    ///Fetcha da Realm gli item creati nel mese della data che viene passata come arg
    func fetchItems(using date: Date) -> [TeenStarFemmina] {
        let range = self.getMonthRange(from: date)
        let predicate1 = NSPredicate(format: "date >= %@", range.lowerBound as CVarArg)
        let predicate2 = NSPredicate(format: "date <= %@", range.upperBound as CVarArg)
        
        let fullPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        
        let realm = try! Realm()
        let objects = realm.objects(TeenStarFemmina.self).filter(fullPredicate)
        return objects.map { $0 }
    }
    
    
    static func getTodayComponents() -> (Int, Int) {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: Date())
        let year = calendar.component(.year, from: Date())
        
        return (month, year)
    }
}
