//
//  SitoWeb.swift
//  SFA
//
//  Created by Dani Tox on 16/03/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var isSelected: Bool = false
    @objc dynamic private var _type: Int = 0
    
    static func initWith(codable: LocationCodable) -> Location {
        let location = Location()
        location.id = codable.id
        location.name = codable.name
        location.type = codable.type
        return location
    }
    
    var type: LocationType {
        get {
            return LocationType(rawValue: self._type)!
        } set {
            self._type = newValue.rawValue
        }
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
}

class SitoWeb : Object {
    @objc dynamic var id : Int = -1
    @objc dynamic var order = -1
    @objc dynamic var nome = ""
    @objc dynamic var descrizione = ""
    @objc public dynamic var urlString = ""
    @objc private dynamic var scuolaTypeRaw = 0
    @objc private dynamic var _categoria = 0
    
    @objc dynamic var location: Location? = nil
    
    static func initFrom(codable: SitoObject) -> SitoWeb {
        let newSite = SitoWeb()
        newSite.id = codable.id
        
        newSite.updateContents(from: codable)
        
        return newSite
    }
    
    func updateContents(from codable: SitoObject) {
        let realm = try! Realm()
        
        self.categoria = codable.type
        
        self.nome = codable.nome
        self.descrizione = codable.descrizione ?? ""
        self.order = codable.order ?? -1
        self.scuolaType = codable.scuolaType
        self.urlString = codable.urlString
        
        if let locationID = codable.locationID {
            self.location = realm.objects(Location.self).filter(NSPredicate(format: "id == %d", locationID)).first
        }
    }
    
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
    case none = 0
    case materiali = 1
    case preghiere = 2
    case facebook = 3
    case instagram = 4
    case youtube = 5
    case calendario = 6
}

struct SitoObject : Codable, Hashable, Equatable {
    var id: Int
    var nome : String
    var urlString : String
    
    var type: SitoCategoria
    var scuolaType: ScuolaType?
    
    var locationID: Int?
    
    var profileName: String? {
        let availableCategories : [SitoCategoria] = [.facebook, .instagram, .youtube]
        guard availableCategories.contains(self.type) else { return nil }
        
        return self.urlString
    }
    
    var url : URL? {
        get { return URL(string: urlString) }
        set { urlString = newValue?.absoluteString ?? "" }
    }
    
    
    static func == (lhs: SitoObject, rhs: SitoObject) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    //probabilemnte inutili
    var descrizione : String?
    var order : Int?
    
    enum CodingKeys: String, CodingKey {
        case id, urlString, type, scuolaType, locationID, descrizione, order
        case nome = "name"
    }
    
    static func initFrom(obj: SitoWeb) -> SitoObject {
        let newCodable = SitoObject(id: obj.id, nome: obj.nome,
                                    urlString: obj.urlString, type: obj.categoria,
                                    scuolaType: obj.scuolaType, locationID: obj.location?.id, descrizione: obj.descrizione,
                                    order: obj.order)
        return newCodable
    }
}

struct LocationCodable: Codable, Equatable {
    var id: Int
    var name: String
    var type: LocationType
    
    var isSelected: Bool = false
    
    static func initFrom(realmObject: Location) -> LocationCodable {
        return LocationCodable(id: realmObject.id, name: realmObject.name, type: realmObject.type, isSelected: realmObject.isSelected)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, type
    }
}

/// Struttura che si ottiene dal server. Contiene la lista dei siti e social in base alla città/diocesi scelta
struct LocalizedList: Codable {
    var siti: [SitoObject]
}

enum LocationType: Int, Codable {
    case diocesi = 1
    case city = 2
}
