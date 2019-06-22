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
        case whatsapp = 1
        case instagram = 2
        case amici = 3
        case libri = 4
        case sport = 5
        case notte = 6
        
        static var allCases: [TaskType] {
            return [
                .whatsapp, .instagram, .amici, .libri, .sport, .notte
            ]
        }
        
        var imageName: String? {
            switch self {
            case .whatsapp:     return "wa_icon"
            case .instagram:    return "ig_icon"
            default: return nil
            }
        }
        
        var emoji: String? {
            switch self {
            case .none:         return "NULL"
            case .whatsapp:     return nil
            case .instagram:    return nil
            case .amici:        return "👫"
            case .libri:        return "📚"
            case .sport:        return "⚽️"
            case .notte:        return "🌝"
            }
        }
        
        var stringValue: String {
            switch self {
            case .none:         return "Vuoto"
            case .instagram:    return "Instagram"
            case .whatsapp:     return "WhatsApp"
            case .sport:        return "Sport"
            case .amici:        return "Amici"
            case .notte:        return "Notte"
            case .libri:        return "Libri"
            }
        }
    }
    
    enum GioProTime: Int, Codable, CaseIterable {
        case none = 0
        case otto = 1
        case tredici = 2
        case diciotto = 3
        case ventiquattro = 4
        
        static var allCases: [GioProTime] {
            return [.otto, .tredici, .diciotto, .ventiquattro]
        }
        
        var stringValue: String {
            switch self {
            case .none: return "NULL"
            case .otto: return "8:00"
            case .tredici: return "13:00"
            case .diciotto: return "18:00"
            case .ventiquattro: return "24:00"
            }
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
