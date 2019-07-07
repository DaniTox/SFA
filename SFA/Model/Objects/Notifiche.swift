//
//  Notifiche.swift
//  MGS
//
//  Created by Dani Tox on 07/07/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

class Notifiche {
    
    enum NotificheType: UInt, CaseIterable {
        case eventiMGS = 1
        case consigliDB = 2
        case sacramenti = 4
        case angeloCustode = 8
        
        static var allCases: [NotificheType] {
            return [ .eventiMGS, .consigliDB, .sacramenti, .angeloCustode ]
        }
        
        public var stringValue: String {
            switch self {
            case .eventiMGS: return "Eventi MGS"
            case .consigliDB: return "Consigli di Don Bosco"
            case .sacramenti: return "Promemoria sacramenti"
            case .angeloCustode: return "Missione dell'angelo custode"
            }
        }
        
        static func getString(from type: NotificheType) -> String {
            return type.stringValue
        }
        
    }
    
    private static func encode(notifiche: Set<NotificheType>) -> UInt {
        if notifiche.isEmpty { return 0 }
        
        var base: UInt = 0
        for notif in notifiche {
            base += notif.rawValue
        }
        
        return base
    }
    
    private static func decode(integer: UInt) -> Set<NotificheType> {
        if integer <= 0 { return [] }
        
        var notifiche: Set<NotificheType> = []
        
        for notifica in NotificheType.allCases {
            let base = integer
            let notifRawValue = notifica.rawValue
            
            let result = base & notifRawValue
            
            if result > 0 {
                notifiche.insert(notifica)
            }
        }
        
        return notifiche
    }
    
    static var activeNotifiche: Set<NotificheType> {
        get {
            let integer = UserDefaults.standard.integer(forKey: "notificheRawValue")
            return Notifiche.decode(integer: UInt(integer))
        } set {
            let integer = Notifiche.encode(notifiche: newValue)
            UserDefaults.standard.set(integer, forKey: "notificheRawValue")
        }
    }
}
