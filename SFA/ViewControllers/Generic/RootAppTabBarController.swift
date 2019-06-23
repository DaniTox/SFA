//
//  RootAppController.swift
//  SFA
//
//  Created by Dani Tox on 24/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit
import SafariServices

class RootAppController : UITabBarController {
    
    var indexController : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillController()
        
        NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main, using: { (notification) in
            self.updateTheme()
        })
        updateTheme()
    }
    
    private func updateTheme() {
        self.tabBar.barStyle = (Theme.current is LightTheme) ? .default : .black
    }
    
    private func fillController() {
        let vc = HomeViewController()
        let nav1 = ThemedNavigationController(rootViewController: vc)
        nav1.tabBarItem.image = #imageLiteral(resourceName: "home")
        self.addChild(nav1)
        
        let vc2 = SitiVC(types: [.materiali, .preghiere])
        let nav2 = ThemedNavigationController(rootViewController: vc2)
        nav2.tabBarItem.image = #imageLiteral(resourceName: "school_bag")
        vc2.title = "Risorse"
        self.addChild(nav2)
        
        
        let vc3 = SocialVC()
        let nav3 = ThemedNavigationController(rootViewController: vc3)
        vc3.title = "Social"
        self.addChild(nav3)
        
        
        let vc4 = SettingsVC()
        vc4.title = "Impostazioni"
        let nav4 = ThemedNavigationController(rootViewController: vc4)
        nav4.tabBarItem.image = UIImage(named: "settings")
        self.addChild(nav4)
        
    }
    
}
