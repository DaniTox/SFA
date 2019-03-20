//
//  SitiPreghiereRequest.swift
//  SFA
//
//  Created by Dani Tox on 02/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

class SitiPreghiereRequest : ToxNetworkRequest, Codable {
    var requestType: String = "preghiere"
    enum CodingKeys : String, CodingKey {
        case requestType = "type"
    }
}
