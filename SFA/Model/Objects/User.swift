//
//  User.swift
//  SFA
//
//  Created by Dani Tox on 23/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation
import RealmSwift

enum ScuolaType : Int, Codable, CaseIterable {
    case medie = 1
    case biennio = 2
    case triennio = 3
    
    var stringValue: String {
        switch self {
        case .medie: return "Medie"
        case .biennio: return "Biennio Superiori"
        case .triennio: return "Triennio Superiori"
        }
    }
}

class User : Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var genderRawValue = 0
    @objc dynamic var scuolaRawValue = 1
    @objc dynamic var apnsToken : String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    var gender : UserGender {
        get {
            return UserGender(rawValue: genderRawValue)!
        } set {
            genderRawValue = newValue.rawValue
        }
    }
    
    var ageScuola : ScuolaType {
        get {
            return ScuolaType(rawValue: scuolaRawValue)!
        } set {
            scuolaRawValue = newValue.rawValue
        }
    }
    
    static func currentUser() -> User {
        let realm = try! Realm()
        let users = realm.objects(User.self)
        if let savedUser = users.first {
            return savedUser
        } else {
            let newUser = User()
            try? realm.write {
                realm.add(newUser, update: true)
            }
            return newUser
        }
    }
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
