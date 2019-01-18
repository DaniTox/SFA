//
//  NotificheVC.swift
//  SFA
//
//  Created by Dani Tox on 21/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit
import UserNotifications

class NotificheVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestNotificationAccess()
    }
    
    private func requestNotificationAccess() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound, .badge, .alert]) { (granted, error) in
            if error != nil {
                print(error!)
                return
            }
            
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Non hai permesso le notifiche... Fanculo")
            }
        }
    }
    
    
    @IBAction func doneAction(_ sender: UIButton) {
        let vc = RootAppController()
        self.present(vc, animated: true)
    }
    
    
}

