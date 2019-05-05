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
    var sentimento7 : GioProNetTask?
    var sentimento11 : GioProNetTask?
    var sentimento14 : GioProNetTask?
    var sentimento17 : GioProNetTask?
    var sentimento20 : GioProNetTask?
    var sentimento23 : GioProNetTask?
    var sentimento2 : GioProNetTask?
    
    var date: Date = Date().startOfDay
    
    func getTask(from index: Int) -> GioProNetTask? {
        switch index {
        case 1:
            return sentimento7
        case 2:
            return sentimento11
        case 3:
            return sentimento14
        case 4:
            return sentimento17
        case 5:
            return sentimento20
        case 6:
            return sentimento23
        case 7:
            return sentimento2
        default:
            return nil
        }
    }
    
    func set(task: GioProNetTask, at index: Int) {
        switch index {
        case 1:
            self.sentimento7 = task
        case 2:
            self.sentimento11 = task
        case 3:
            self.sentimento14 = task
        case 4:
            self.sentimento17 = task
        case 5:
            self.sentimento20 = task
        case 6:
            self.sentimento23 = task
        case 7:
            self.sentimento2 = task
        default:
            break
        }
    }
}
