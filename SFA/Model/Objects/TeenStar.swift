//
//  TeenStar.swift
//  SFA
//
//  Created by Dani Tox on 15/03/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import RealmSwift

@objc protocol TeenStarDerivative {
    @objc var id : String { get set }
    @objc var date : Date { get set }
    @objc var sentimentiTable : SentimentoTable? { get set }
    var gender : Int { get }
}

class TeenStarMaschio : Object, TeenStarDerivative {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var date = Date().startOfDay
    @objc dynamic var sentimentiTable : SentimentoTable? = SentimentoTable()
    
    var gender : Int {
        return 0
    }
    override static func primaryKey() -> String {
        return "id"
    }
}

class TeenStarFemmina : Object, TeenStarDerivative {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var date = Date().startOfDay
    @objc dynamic var sentimentiTable : SentimentoTable? = SentimentoTable()
    @objc dynamic var cicloTable : CicloTable? = CicloTable()
    
    var gender : Int {
        return 1
    }
    
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
}
