//
//  TeenStarTable.swift
//  SFA
//
//  Created by Dani Tox on 02/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import CoreData

class TeenStarTable: NSManagedObject {
    var isEmpty : Bool {
        var counter : Int = 0
        if self.sentimento8h != -1 {
            counter += 1
        }
        if self.sentimento14h != -1 {
            counter += 1
        }
        if self.sentimento20h != -1 {
            counter += 1
        }
        if self.ciclo != -1 {
            counter += 1
        }
        if self.muco != -1 {
            counter += 1
        }
        return (counter > 0) ? false : true
    }
}
