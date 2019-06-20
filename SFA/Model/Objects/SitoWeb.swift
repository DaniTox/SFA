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
    @objc dynamic var isSelected: Bool = false
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
    @objc dynamic var isSelected: Bool = false
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
    @objc dynamic var id : Int = -1
    @objc dynamic var order = -1
    @objc dynamic var nome = ""
    @objc dynamic var descrizione = ""
    @objc public dynamic var urlString = ""
    @objc private dynamic var scuolaTypeRaw = 0
    @objc private dynamic var _categoria = 0
    
    @objc dynamic var diocesi: Diocesi? = nil
    @objc dynamic var city: City? = nil
    
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
        
        if let cityID = codable.cittaID {
            self.city = realm.objects(City.self).filter(NSPredicate(format: "id == %d", cityID)).first
        }
        if let diocesiID = codable.diocesiID {
            self.diocesi = realm.objects(Diocesi.self).filter(NSPredicate(format: "id == %d", diocesiID)).first
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

struct SitoObject : Codable {
    var id: Int
    var nome : String
    var urlString : String
    
    var type: SitoCategoria
    var scuolaType: ScuolaType?
    
    var diocesiID: Int?
    var cittaID: Int?
    
    var profileName: String? {
        let availableCategories : [SitoCategoria] = [.facebook, .instagram, .youtube]
        guard availableCategories.contains(self.type) else { return nil }
        
        return self.urlString
    }
    
    var url : URL? {
        get { return URL(string: urlString) }
        set { urlString = newValue?.absoluteString ?? "" }
    }
    
    //probabilemnte inutili
    var descrizione : String?
    var order : Int?
    
    enum CodingKeys: String, CodingKey {
        case id, urlString, type, scuolaType, diocesiID, cittaID, descrizione, order
        case nome = "name"
    }
    
    static func initFrom(obj: SitoWeb) -> SitoObject {
        let newCodable = SitoObject(id: obj.id, nome: obj.nome,
                                    urlString: obj.urlString, type: obj.categoria,
                                    scuolaType: obj.scuolaType, diocesiID: obj.diocesi?.id,
                                    cittaID: obj.city?.id, descrizione: obj.descrizione,
                                    order: obj.order)
        return newCodable
    }
}

struct DiocesiCodable: Codable, Equatable {
    var id: Int
    var name: String
    
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

struct CityCodable: Codable, Equatable {
    var id: Int
    var name: String
    var diocesiID: Int
    
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, name, diocesiID
    }
}


/// Struttura che si ottiene dal server. Contiene la lista dei siti e social in base alla città/diocesi scelta
struct LocalizedList: Codable {
    var siti: [SitoObject]
}
