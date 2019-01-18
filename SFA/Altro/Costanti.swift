//
//  Costanti.swift
//  SFA
//
//  Created by Dani Tox on 14/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation

let IS_FIRST_LAUNCH = "is_first_launch"
let NOTIFICHE_DA_RICEVERE = "notifiche_da_ricevere"

var isAlreadyLaunched : Bool {
    get {
        return UserDefaults.standard.bool(forKey: IS_FIRST_LAUNCH)
    } set {
        UserDefaults.standard.set(newValue, forKey: IS_FIRST_LAUNCH)
    }
}

var notificheDaRicevere : [String] {
    get {
        if let nots = UserDefaults.standard.array(forKey: NOTIFICHE_DA_RICEVERE) as? [String] {
            return nots
        } else {
            return []
        }
    } set {
        UserDefaults.standard.set(newValue, forKey: NOTIFICHE_DA_RICEVERE)
    }
}


var userLogged : User? {
    get {
        let data = KeychainWrapper.standard.data(forKey: "userLogged") ?? Data()
        return try? JSONDecoder().decode(User.self, from: data)
    } set {
        let data = try? JSONEncoder().encode(newValue)
        KeychainWrapper.standard.set(data ?? Data(), forKey: "userLogged")
    }
}

class RegolaFile : Codable {
    var categories : [RegolaCategoryFile] = []
    init() {}
}
class RegolaCategoryFile : Codable {
    var id : String
    var name : String
    var domande : [RegolaDomandaFile]
}
class RegolaDomandaFile : Codable {
    var idDomanda: Int
    var domanda : String
    var rispsota : String?
}

enum LocalDBError: Error {
    case foundNil(String)
    case inconsistency(String)
    case warning(String)
    case fatal(String)
}

enum ToxError : Error {
    case generic
    case noteRelated(String)
}

let genderArray : [String] = ["Maschio", "Femmina"]
let EMOZIONI : [String] = ["Fiducia", "Collera", "Paura", "Tristezza", "Gioia", "Equilibrio"]

let TEENSTAR_INDICES : [String] = ["Sentimento prevalente alle ore 8:00:",
                                   "Sentimento prevalente alle ore 14:00:",
                                   "Sentimento prevalente alle ore 20:00:",
                                   "Ciclo: seleziona il tipo di colore o simbolo:"]

enum CicloColor : Int16, Codable {
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

let CICLO_COLORS : [String] = ["rosso",
                               "verde",
                               "giallo",
                               "bianco",
                               "croce"]

let COLORS_DESCRIPTIONS : [CicloColor : String] = [
    .rosso : "Presenza di sangue nei genitali sia che provenga dalla mestruazione o da perdite intermestruali",
    .verde : "Giorni senza muco o con sensazione di secchezza",
    .giallo : "Giorni con presenza di muco appiccicoso e opaco, o una mucosità spessa senza variazioni",
    .bianco : "Giorni di muco cervicale trasparente, elastico, vulva bagnata o sensazione di umidità",
    .croce : "Giorno in cui è avvenuta la mestruazione"
]
