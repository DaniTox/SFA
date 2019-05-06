//
//  GioProNet.swift
//  MGS
//
//  Created by Dani Tox on 05/05/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import RealmSwift

class GioProNet : Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var date = Date().startOfDay
    @objc dynamic var taskTable: TaskTable? = TaskTable()
    
    override static func primaryKey() -> String {
        return "id"
    }
}

class TaskTable: Object {
    @objc private dynamic var task7 = GioProNetTask.none.rawValue
    @objc private dynamic var task11 = GioProNetTask.none.rawValue
    @objc private dynamic var task14 = GioProNetTask.none.rawValue
    @objc private dynamic var task17 = GioProNetTask.none.rawValue
    @objc private dynamic var task20 = GioProNetTask.none.rawValue
    @objc private dynamic var task23 = GioProNetTask.none.rawValue
    @objc private dynamic var task2 = GioProNetTask.none.rawValue
    
    var taskAt7: GioProNetTask {
        get { return GioProNetTask(rawValue: task7)! }
        set { task7 = newValue.rawValue }
    }
    
    var taskAt11: GioProNetTask {
        get { return GioProNetTask(rawValue: task11)! }
        set { task11 = newValue.rawValue }
    }
    
    var taskAt14: GioProNetTask {
        get { return GioProNetTask(rawValue: task14)! }
        set { task14 = newValue.rawValue }
    }
    
    var taskAt17: GioProNetTask {
        get { return GioProNetTask(rawValue: task17)! }
        set { task17 = newValue.rawValue }
    }
    
    var taskAt20: GioProNetTask {
        get { return GioProNetTask(rawValue: task20)! }
        set { task20 = newValue.rawValue }
    }
    
    var taskAt23: GioProNetTask {
        get { return GioProNetTask(rawValue: task23)! }
        set { task23 = newValue.rawValue }
    }
    
    var taskAt2: GioProNetTask {
        get { return GioProNetTask(rawValue: task2)! }
        set { task2 = newValue.rawValue }
    }
    
}

class GioProNetWeek: Hashable {
    static func == (lhs: GioProNetWeek, rhs: GioProNetWeek) -> Bool {
        return lhs.startOfWeek == rhs.startOfWeek
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(startOfWeek)
    }
    
    var id: UUID = UUID()
    var startOfWeek: Date
    var tables : [GioProNet]
    
    init(startOfWeek : Date) {
        self.startOfWeek = startOfWeek
        self.tables = []
    }
    
}

enum GioProNetTask: Int, Codable, CaseIterable {
    case none = 0
    case facebook = 1
    case instagram = 2
    case youtube = 3
    case whatsapp = 4
    case internet = 5
    case videogiochi = 6
    case musica = 7
    case sport = 8
    case scuola = 9
    case famiglia = 10
    case amici = 11
    case notte = 12
}


class GioProMemory {
    var task7 : GioProNetTask?
    var task11 : GioProNetTask?
    var task14 : GioProNetTask?
    var task17 : GioProNetTask?
    var task20 : GioProNetTask?
    var task23 : GioProNetTask?
    var task2 : GioProNetTask?
    
    var date: Date = Date().startOfDay
    
    func getTask(from index: Int) -> GioProNetTask? {
        switch index {
        case 1:
            return task7
        case 2:
            return task11
        case 3:
            return task14
        case 4:
            return task17
        case 5:
            return task20
        case 6:
            return task23
        case 7:
            return task2
        default:
            return nil
        }
    }
    
    func set(task: GioProNetTask, at index: Int) {
        switch index {
        case 1:
            self.task7 = task
        case 2:
            self.task11 = task
        case 3:
            self.task14 = task
        case 4:
            self.task17 = task
        case 5:
            self.task20 = task
        case 6:
            self.task23 = task
        case 7:
            self.task2 = task
        default:
            break
        }
    }
}
