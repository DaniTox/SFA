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
    let tasks = List<GioProNetTask>()
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    ///Ritorna il task nella lista dei tasks che ha come time quello passato come argomento.
    ///Se non esiste, lo crea e lo aggiunge alla lista
    func getTask(at time: GioProNetTask.GioProTime) -> GioProNetTask {
        if let taskObject = Array(self.tasks).filter({ $0.time == time }).first {
            return taskObject
        } else {
            let newTask = GioProNetTask()
            newTask.time = time
            newTask.taskType = .none
            
            let realm = try! Realm()
            try? realm.write {
                self.tasks.append(newTask)
            }
            return newTask
        }
    }
    
    /// Ritorna true se la lista dei task di questo item è vuota o se i task che ha nella lista sono tutti task vuoti (con taskType == .none)
    var isConsideredEmpty: Bool {
        if self.tasks.isEmpty { return true }
        var counter: Int = 0
        
        for task in self.tasks {
            if task.taskType != .none {
                counter += 1
            }
        }
        return counter == 0
    }
}

class GioProNetTask: Object {
    enum TaskType: Int, Codable, CaseIterable {
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
        
        static var allCases: [TaskType] {
            return [
                .facebook, .instagram, .youtube, . whatsapp, . internet, .videogiochi,
                .musica, .sport, .scuola, .famiglia, .amici, .notte
            ]
        }
    }
    
    enum GioProTime: Int, Codable, CaseIterable {
        case none = 0
        case two = 1
        case seven = 2
        case eleven = 3
        case fourteen = 4
        case seventeen = 5
        case twenty = 6
        case twentythree = 7
        
        static var allCases: [GioProTime] {
            return [.seven, .eleven, .fourteen, .seventeen, .twenty, .twentythree, .two]
        }
    }
    
    let gioProItem = LinkingObjects(fromType: GioProNet.self, property: "tasks")
    @objc private dynamic var _taskType = 0
    @objc private dynamic var _time = 0
    
    var taskType: TaskType {
        get { return TaskType(rawValue: self._taskType)! }
        set { self._taskType = newValue.rawValue }
    }
    
    var time: GioProTime {
        get { return GioProTime(rawValue: self._time)! }
        set { self._time = newValue.rawValue }
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
