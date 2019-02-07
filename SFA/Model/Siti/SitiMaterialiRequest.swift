//
//  SitiWebRequest.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

class SitiMaterialiRequest : ToxNetworkRequest, Codable {
    var requestType: String = "siti-materiali"
    enum CodingKeys : String, CodingKey {
        case requestType = "type"
    }
}
