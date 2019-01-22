//
//  URLs.swift
//  SFA
//
//  Created by Dani Tox on 23/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation

struct URLs {
    #if arch(x86_64)
    static let mainUrl = "http://localhost:8080"
    #else
    static let mainUrl = "http://192.168.1.77:8080"
    #endif
    
}
