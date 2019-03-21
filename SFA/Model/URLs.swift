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
        static let mainUrl = "http://192.168.1.77:5000"
    #else
        static let mainUrl = "http://192.168.1.77:5000"
//        static let mainUrl = "http://api.suppstudenti.com:5000"
    #endif
}
