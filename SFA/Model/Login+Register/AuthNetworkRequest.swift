//
//  AuthNetworkRequest.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

class AuthNetworkRequest : ToxNetworkRequest, Codable {
    var requestType: String = "login_user"
    var credentials : User?
    
    enum CodingKeys : String, CodingKey {
        case requestType = "type"
        case credentials
    }
}
