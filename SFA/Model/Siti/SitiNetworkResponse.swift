//
//  SitiNetworkResponse.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

struct SitiNetworkResponse : ToxNetworkResponse, Codable {
    var code: String
    var message: String
    var siti : [SitoObject] = []
    var categoria: SitoCategoriaObject

    var errorCode: String?
    
//    init() {
//        code = "NO"
//        message = "Default error message after initialization"
//    }
}
