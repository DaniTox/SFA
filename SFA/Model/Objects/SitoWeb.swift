//
//  SitoWeb.swift
//  SFA
//
//  Created by Dani Tox on 16/03/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import RealmSwift

class SitoWebCategoria : Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var idCategoriaType: Int = -1
    @objc dynamic var order = -1
    @objc dynamic var nome = ""
    @objc dynamic var descrizione = ""
    let siti = List<SitoWeb>()
    
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
    let categoria = LinkingObjects(fromType: SitoWebCategoria.self, property: "siti")
    
    var url : URL? {
        get { return URL(string: urlString) }
        set { urlString = newValue?.absoluteString ?? "" }
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

struct SitoObject : Codable {
    var id: Int?
    var nome : String
    var order : Int?
    var descrizione : String?
    var urlString : String
    var categoriaID: Int?
    var scuolaType: ScuolaType?
}

struct SitoCategoriaObject : Codable {
    var id: Int?
    var order : Int?
    var nome : String
    var descrizione : String?
}

enum WebsiteType: Int, Codable {
    case materiali = 0
    case preghiere = 1
}
