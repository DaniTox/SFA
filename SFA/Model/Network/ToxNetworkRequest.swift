//
//  ToxNetworkRequest.swift
//  SFA
//
//  Created by Dani Tox on 23/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation

class ToxNetworkRequest : Encodable {
    var requestType : String = ""
    var credentials : User?
    
    enum CodingKeys : String, CodingKey {
        case requestType = "type"
        case credentials
    }
}
