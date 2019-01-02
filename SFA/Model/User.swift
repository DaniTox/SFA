//
//  User.swift
//  SFA
//
//  Created by Dani Tox on 23/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation

class User : Codable {
    var name: String = ""
    var cognome : String = ""
    var age : Int = -1
    var gender : UserGender?
    var email : String = ""
    var token : String = ""
    var password: String?
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
