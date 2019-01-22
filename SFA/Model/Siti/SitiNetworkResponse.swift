//
//  SitiNetworkResponse.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

class SitiNetworkResponse : ToxNetworkResponse, Codable {
    var code: String
    
    var message: String
    
    var errorCode: String?
    
    var sites : [SitoCategoriaObject]?
    
    init() {
        code = "NO"
        message = "Default error message after initialization"
    }
}
