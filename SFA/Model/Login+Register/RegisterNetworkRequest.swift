//
//  AuthNetworkRequest.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

class RegisterNetworkRequest : ToxNetworkRequest, Codable {
    var requestType: String = "register"
    var credentials : User?
    
    enum CodingKeys : String, CodingKey {
        case requestType = "type"
        case credentials = "user"
    }
}
