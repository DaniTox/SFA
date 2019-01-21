//
//  SitoWeb.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import CoreData

class SitoWeb : NSManagedObject {
    
}

class SitoWebCategoria : NSManagedObject {
    
}


class SitoObject : Codable {
    var nome : String
    var idOrder : Int
    var descrizione : String?
    var urlString : String
    //    var url : URL? {
    //        return URL(string: urlString)
    //    }
    
    init() {
        nome = ""
        idOrder = -1
        urlString = ""
    }
    
    enum CodingKeys : String, CodingKey {
        case urlString = "url"
        case nome
        case descrizione
        case idOrder
    }
}

class SitoCategoriaObject : Codable {
    var idOrder : Int
    var name : String
    var descrizione : String?
    var sites : [SitoObject]
    
//    init() {
//        idOrder = -1
//        name = ""
//        sites = []
//    }

}
