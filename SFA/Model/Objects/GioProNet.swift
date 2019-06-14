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
        if let taskObject = self.tasks.filter(.init(format: "_time == %d", time.rawValue)).first {
            return taskObject
        } else {
            let newTask = GioProNetTask()
            newTask.time = time
            newTask.taskType = .none
            
            self.tasks.append(newTask)
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


//class GioProMemory {
//    var task7 : GioProNetTask?
//    var task11 : GioProNetTask?
//    var task14 : GioProNetTask?
//    var task17 : GioProNetTask?
//    var task20 : GioProNetTask?
//    var task23 : GioProNetTask?
//    var task2 : GioProNetTask?
//
//    var date: Date = Date().startOfDay
//
//    func getTask(from index: Int) -> GioProNetTask? {
//        switch index {
//        case 1:
//            return task7
//        case 2:
//            return task11
//        case 3:
//            return task14
//        case 4:
//            return task17
//        case 5:
//            return task20
//        case 6:
//            return task23
//        case 7:
//            return task2
//        default:
//            return nil
//        }
//    }
//
//    func set(task: GioProNetTask, at index: Int) {
//        switch index {
//        case 1:
//            self.task7 = task
//        case 2:
//            self.task11 = task
//        case 3:
//            self.task14 = task
//        case 4:
//            self.task17 = task
//        case 5:
//            self.task20 = task
//        case 6:
//            self.task23 = task
//        case 7:
//            self.task2 = task
//        default:
//            break
//        }
//    }
//}
