//
//  Notifiche.swift
//  MGS
//
//  Created by Dani Tox on 07/07/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation
import OneSignal


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
        
        public var tagKey: String {
            switch self {
            case .eventiMGS: return "eventiMGS"
            case .consigliDB: return "consigliDB"
            case .sacramenti: return "sacramenti"
            case .angeloCustode: return "missioneAC"
            }
        }
        
    }
    
    public static func encode(notifiche: Set<NotificheType>) -> UInt {
        if notifiche.isEmpty { return 0 }
        
        var base: UInt = 0
        for notif in notifiche {
            base += notif.rawValue
        }
        
        return base
    }
    
    public static func decode(integer: UInt) -> Set<NotificheType> {
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
    
    static var areNotificheActive: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "areNotificheActive")
        } set {
            UserDefaults.standard.set(newValue, forKey: "areNotificheActive")
        }
    }
    
    static var userDismissedNotifications: Bool {
        let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
        return status.subscriptionStatus.subscribed
    }
    
    static func requestAuthorization() {
        OneSignal.promptForPushNotifications { (accepted) in
            OneSignal.setSubscription(true)
        }
    }
    
    static func subscribeToActiveNotifications() {
        var tags: [AnyHashable: Any] = [:]
        
        let activeNotifiche = Notifiche.activeNotifiche
        
        for type in Notifiche.NotificheType.allCases {
            let key = type.tagKey
            let value = activeNotifiche.contains(type) ? "1" : "0"
            
            tags[key] = value
        }
        
        OneSignal.sendTags(tags)
    }
    
    static func unsubscribeToAllNotifications() {
        var tags: [AnyHashable: Any] = [:]
    
        for type in Notifiche.NotificheType.allCases {
            let key = type.tagKey
            tags[key] = "0"
        }
        
        OneSignal.sendTags(tags)
    }
    
    static func openSettings() {
        OneSignal.presentAppSettings()
    }
    
    static func updateStatus() {
        if Notifiche.areNotificheActive {
            Notifiche.subscribeToActiveNotifications()
        } else {
            Notifiche.unsubscribeToAllNotifications()
        }
    }
}
