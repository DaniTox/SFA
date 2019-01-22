//
//  AuthNetworkResponse.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

class AuthNetworkResponse : ToxNetworkResponse, Codable {
    var code: String
    
    var message: String
    
    var errorCode: String?
    
    var user: User?
    
    init() {
        code = "NO"
        message = "Default error message after initialization..."
    }
}
