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
    
    
    public func getFarestDate() -> Date {
        let realm = try! Realm()
        let obj = realm.objects(TeenStarMaschio.self).sorted(byKeyPath: "date", ascending: true).first
        return obj?.date ?? Date()
    }
    
    public func getYearsList(basedOn date: Date) -> [Int] {
        let calendar = Calendar.current
        
        let lowerDate = calendar.component(.year, from: date)
        let thisYear = calendar.component(.year, from: Date())

        return Array(lowerDate...thisYear)
    }
    
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
}
