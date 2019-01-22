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
    var url : String
//    var urlObject : URL? {
//        return URL(string: url)
//    }
    
    init() {
        nome = ""
        idOrder = -1
        url = ""
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
