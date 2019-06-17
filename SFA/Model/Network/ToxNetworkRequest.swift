//
//  ToxNetworkRequest.swift
//  SFA
//
//  Created by Dani Tox on 23/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation

protocol ToxNetworkRequest : Codable {
    var requestType : RequestType { get set }
}

/// Liste dei tipi di richieste
///
/// - preghiere
/// - materiali
/// - diocesi
/// - cities
enum RequestType: String, Codable {
    case preghiere = "preghiere"
    case materiali = "materiali"
    case diocesi = "diocesi"
    case cities = "citta"
}

/// Struttura di una richiesta. Contiene solo la requestType che è la path del server.
/// - Esempio: requestType = "example" --> suppstudenti.com:5000/example
struct BasicRequest: ToxNetworkRequest {
    var requestType: RequestType
    
    init(requestType: RequestType) {
        self.requestType = requestType
    }
    
    enum CodingKeys: String, CodingKey {
        case requestType = "type"
    }
}
