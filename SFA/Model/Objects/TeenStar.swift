//
//  TeenStar.swift
//  SFA
//
//  Created by Dani Tox on 15/03/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

@objc protocol TeenStarDerivative {
    @objc var id : String { get set }
    @objc var date : Date { get set }
}

class TeenStarMaschio : Object, TeenStarDerivative {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var date = Date().startOfDay
    @objc dynamic var sentimentiTable : SentimentoTable? = SentimentoTable()
    
    override static func primaryKey() -> String {
        return "id"
    }
}

class TeenStarFemmina : Object, TeenStarDerivative {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var date = Date().startOfDay
    @objc dynamic var cicloTable : CicloTable? = CicloTable()
    
    override static func primaryKey() -> String {
        return "id"
    }
}

class SentimentoTable : Object {
    @objc private dynamic var sentimento8  = Emozione.none.rawValue
    @objc private dynamic var sentimento14  = Emozione.none.rawValue
    @objc private dynamic var sentimento20  = Emozione.none.rawValue
    
    var sentimentoOre8 : Emozione {
        get { return Emozione(rawValue: sentimento8)! }
        set { sentimento8 = newValue.rawValue }
    }
    
    var sentimentoOre14 : Emozione {
        get { return Emozione(rawValue: sentimento14)! }
        set { sentimento14 = newValue.rawValue }
    }
    
    var sentimentoOre20 : Emozione {
        get { return Emozione(rawValue: sentimento20)! }
        set { sentimento20 = newValue.rawValue }
    }
    
}

class CicloTable : Object {
    @objc private dynamic var cicloColorSelected  = CicloColor.none.rawValue
    
    var cicloColor : CicloColor {
        get { return CicloColor(rawValue: cicloColorSelected)! }
        set { cicloColorSelected = newValue.rawValue }
    }
    
    static var colorDescriptions: [CicloColor : String] {
        return descriptionsCiclo
    }
}

enum TeenStarType {
    case maschio
    case femmina
}

enum CicloColor : Int, Codable {
    case none = -1
    case rosso = 0
    case verde = 1
    case giallo = 2
    case bianco = 3
    case croce = 4
    
    static func getColorFrom(str: String) -> CicloColor {
        let colorStr = str.lowercased()
        switch colorStr {
        case "rosso":
            return .rosso
        case "verde":
            return .verde
        case "giallo":
            return .giallo
        case "bianco":
            return .bianco
        case "croce":
            return .croce
        default:
            fatalError("Errore CicloColor con questa stringa non esiste")
        }
    }
    
    func getViewColor() -> UIColor {
        switch self {
        case .none:
            return Theme.current.backgroundColor
        case .rosso:
            return .red
        case .verde:
            return .green
        case .giallo:
            return .yellow
        case .bianco:
            return .white
        case .croce:
            return .cyan
        }
    }
    
    func getDescriptionText() -> String {
        if let str = descriptionsCiclo[self] {
            return str
        } else {
            return ""
        }
    }
}


fileprivate let descriptionsCiclo : [CicloColor : String] = [
    .rosso : "Presenza di sangue nei genitali sia che provenga dalla mestruazione o da perdite intermestruali",
    .verde : "Giorni senza muco o con sensazione di secchezza",
    .giallo : "Giorni con presenza di muco appiccicoso e opaco, o una mucosità spessa senza variazioni",
    .bianco : "Giorni di muco cervicale trasparente, elastico, vulva bagnata o sensazione di umidità",
    .croce : "Giorno in cui è avvenuta la mestruazione"
]


class TeenStarWeek<T: TeenStarDerivative & Object> : Hashable {
    static func == (lhs: TeenStarWeek<T>, rhs: TeenStarWeek<T>) -> Bool {
        return lhs.startOfWeek == rhs.startOfWeek //&& lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(startOfWeek)
        //        hasher.combine(id)
    }
    
    var id: UUID = UUID()
    var startOfWeek: Date
    var tables : [T]
    
    init(startOfWeek : Date) {
        self.startOfWeek = startOfWeek
        self.tables = []
    }
    
}
