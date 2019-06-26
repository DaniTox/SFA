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
    
    static func getMonthRange(from date: Date) -> ClosedRange<Date> {
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
    
}
