//
//  User.swift
//  SFA
//
//  Created by Dani Tox on 23/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation

enum ScuolaType : Int,  Codable {
    case medie = 1
    case biennio = 2
    case triennio = 3
}

class User : Codable {
    var gender : UserGender
    var ageScuola : ScuolaType
    var apnsToken : String = ""
}

enum UserGender : Int, Codable {
    case boy = 0
    case girl = 1
    
    static func getGenderFrom(str: String) -> UserGender {
        if str == "Maschio" {
            return UserGender.boy
        } else {
            return UserGender.girl
        }
    }
}
