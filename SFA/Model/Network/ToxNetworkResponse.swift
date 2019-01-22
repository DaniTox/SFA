//
//  ToxNetworkResponse.swift
//  SFA
//
//  Created by Dani Tox on 23/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation

protocol ToxNetworkResponse {
    var code : String { get set }
    var message : String { get set }
    var errorCode : String? { get set }
}
