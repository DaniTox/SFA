//
//  Emozione.swift
//  SFA
//
//  Created by Dani Tox on 03/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

enum Emozione : Int, Codable {
    case fiducioso = 0
    case aggressività = 1
    case paura = 2
    case tristezza = 3
    case gioia = 4
    case equilibrio = 5
    
    static func getEmozioneFrom(str: String) -> Emozione {
        let emozioneStr = str.lowercased()
        switch emozioneStr {
        case "fiducia":
            return Emozione.fiducioso
        case "collera":
            return Emozione.aggressività
        case "paura":
            return Emozione.paura
        case "tristezza":
            return Emozione.tristezza
        case "gioia":
            return Emozione.gioia
        case "equilibrio":
            return Emozione.equilibrio
        default:
            fatalError("Emozione.getEmozioneFrom(str) non equivale a niente. Probabilmente hai sbagliato a scrivere un'emozione nel codice")
        }
    }
}

//["Fiducia", "Collera", "Paura", "Tristezza", "Gioia", "Equilibrio"]
