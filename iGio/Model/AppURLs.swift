//
//  AppURLs.swift
//  iGio
//
//  Created by Dani Tox on 19/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

/// Liste dei tipi di richieste
///
/// - preghiere
/// - materiali
/// - diocesi
/// - cities
public enum RequestType: String, Codable {
    case preghiere = "preghiere"
    case materiali = "materiali"
    case locations = "locations"
    case diocesi = "diocesi"
    case cities = "citta"
    case localizedSites = "resources"
}

struct AppURL {
    #if DEBUG
    static let hostname = "http://192.168.1.5/iGio-Server"
    #else
    static let hostname = "https://danitoxserver.ddns.net/iGio-Server"
    #endif
    static let calendario = "http://www.mgslombardiaemilia.it/calendario"
}
