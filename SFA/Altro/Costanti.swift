//
//  Costanti.swift
//  SFA
//
//  Created by Dani Tox on 14/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation

let IS_FIRST_LAUNCH = "is_first_launch"

var isAlreadyLaunched : Bool {
    get {
        return UserDefaults.standard.bool(forKey: IS_FIRST_LAUNCH)
    } set {
        UserDefaults.standard.set(newValue, forKey: IS_FIRST_LAUNCH)
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
                                   "Simbolo o colore",
                                   "Tipo di muco"]
