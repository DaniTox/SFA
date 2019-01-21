//
//  ToxNetworkResponse.swift
//  SFA
//
//  Created by Dani Tox on 23/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation

class ToxNetworkResponse : Codable {
    var code : String
    var message : String
    var errorCode : String?
    
    var user : User?
    var sites : [SitoCategoriaObject]?
}
