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
    let categoria = LinkingObjects(fromType: SitoWebCategoria.self, property: "siti")
    
    var url : URL {
        get { return URL(string: urlString)! }
        set { urlString = newValue.absoluteString }
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
}

struct SitoCategoriaObject : Codable {
    var idOrder : Int
    var nome : String
    var descrizione : String?
    var sites : [SitoObject]
}
