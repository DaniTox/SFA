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
    
    var settingsString: String {
        switch self {
        case .medie: return "Medie"
        case .biennio: return "Biennio"
        case .triennio: return "Triennio"
        }       
    }
    
    static var allCases: [ScuolaType] {
        return [.medie, .biennio, .triennio]
    }
}

class GioUser: Codable, CustomStringConvertible {
    var id: UUID = UUID() { didSet { save() }}
    var gender: UserGender = .boy { didSet { save() }}
    var scuolaType: ScuolaType = .medie { didSet { save() }}
    var apnsToken: String = "" { didSet { save() }}
    
    func save() {
        let url = FileManager.userDirectory
        guard let data = try? JSONEncoder().encode(self) else { return }
        try? data.write(to: url)
    }
    
    static func currentUser() -> GioUser {
        if isUserConvertedToJSON {
            let userDir = FileManager.userDirectory
            guard let data = try? Data(contentsOf: userDir) else { return GioUser() }
            guard let user = try? JSONDecoder().decode(GioUser.self, from: data) else { return GioUser() }
            
            return user
        } else {
            //convert and return
            let oldStyleUser = User.currentUser()
            
            let newStyleUser = GioUser()
            newStyleUser.id = UUID(uuidString: oldStyleUser.id) ?? UUID()
            newStyleUser.gender = oldStyleUser.gender
            newStyleUser.scuolaType = ScuolaType(rawValue: oldStyleUser.scuolaRawValue) ?? .medie
            newStyleUser.apnsToken = oldStyleUser.apnsToken
            
            isUserConvertedToJSON = true
            
            newStyleUser.save()
            
            return newStyleUser
        }
    }
    
    var description: String {
        String("age: \(self.scuolaType.stringValue), gender: \(self.gender.stringValue), apns: \(self.apnsToken), id: \(self.id.uuidString)")
    }
}

//this class is temporary. After all users will switch to the new version that doesn't use Realm, it will be deleted
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
                realm.add(newUser, update: .modified)
            }
            return newUser
        }
    }
}

enum UserGender : Int, Codable, CaseIterable {
    case boy = 0
    case girl = 1
    
    var stringValue: String {
        switch self {
        case .boy: return "Maschio"
        case .girl: return "Femmina"
        }
    }
    
    static func getGenderFrom(str: String) -> UserGender {
        if str == "Maschio" {
            return UserGender.boy
        } else {
            return UserGender.girl
        }
    }
    
    static var allCases: [UserGender] {
        return [.boy, .girl]
    }
}
