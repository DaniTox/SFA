//
//  ToxNetworkRequest.swift
//  SFA
//
//  Created by Dani Tox on 23/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation

protocol ToxNetworkRequest : Codable {
    var requestType : String { get set }
}

