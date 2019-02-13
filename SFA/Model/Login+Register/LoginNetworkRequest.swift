//
//  LoginNetworkRequest.swift
//  SFA
//
//  Created by Dani Tox on 13/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

class LoginNetworkRequest : ToxNetworkRequest, Codable {
    var requestType: String = "login"
    var user : User?
    var password : String?
    
    init() {
        user = nil
        password = nil
    }
}
