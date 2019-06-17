//
//  SitoWeb.swift
//  SFA
//
//  Created by Dani Tox on 16/03/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import RealmSwift

class Diocesi: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    let cities = List<City>()
    
    static func initWith(codable: DiocesiCodable) -> Diocesi {
        let diocesi = Diocesi()
        diocesi.id = codable.id
        diocesi.name = codable.name
        return diocesi
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
}

class City: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    let diocesi = LinkingObjects(fromType: Diocesi.self, property: "cities")
    
    static func initWith(codable: CityCodable) -> City {
        let city = City()
        city.id = codable.id
        city.name = codable.name
        
        let realm = try! Realm()
        let diocesis = realm.objects(Diocesi.self).filter(NSPredicate(format: "id == %d", codable.diocesiID))
        if let diocesi = diocesis.first {
            diocesi.cities.append(city)
        }
        return city
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
}

class SitoWeb : Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var order = -1
    @objc dynamic var nome = ""
    @objc dynamic var descrizione = ""
    @objc private dynamic var urlString = ""
    @objc private dynamic var scuolaTypeRaw = 0
    @objc private dynamic var _categoria = 0
    
    @objc dynamic var diocesi: Diocesi? = nil
    @objc dynamic var city: City? = nil
    
    var profileName: String? {
        let availableCategories : [SitoCategoria] = [.facebook, .instagram, .youtube]
        guard availableCategories.contains(self.categoria) else { return nil }
        
        return self.urlString
    }
    
    var url : URL? {
        get { return URL(string: urlString) }
        set { urlString = newValue?.absoluteString ?? "" }
    }
    
    var categoria: SitoCategoria {
        get { return SitoCategoria(rawValue: self._categoria)! }
        set { self._categoria = newValue.rawValue }
    }
    
    var scuolaType: ScuolaType? {
        get {
            switch scuolaTypeRaw {
            case 1:
                return ScuolaType.medie
            case 2:
                return ScuolaType.biennio
            case 3:
                return ScuolaType.triennio
            default:
                return nil
            }
        } set {
            if let val = newValue {
                scuolaTypeRaw = val.rawValue
            } else {
                scuolaTypeRaw = 0
            }
        }
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
}

enum SitoCategoria: Int, Codable {
    case none = -1
    case materiali = 0
    case preghiere = 1
    case facebook = 2
    case instagram = 3
    case youtube = 4
}

struct SitoObject : Codable {
    var id: Int?
    var nome : String
    var order : Int?
    var descrizione : String?
    var urlString : String
    var categoriaID: SitoCategoria?
    var scuolaType: ScuolaType?
    
    var diocesiID: Int?
    var cittaID: Int?
}

struct DiocesiCodable: Codable {
    var id: Int
    var name: String
}

struct CityCodable: Codable {
    var id: Int
    var name: String
    var diocesiID: Int
}
