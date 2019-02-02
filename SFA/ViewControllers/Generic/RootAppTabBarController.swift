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
        self.delegate = self
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
        self.addChild(nav1)
        
//        let vc2 = SitoVC()
        let vc2 = SitiListVC()  
        let nav2 = ThemedNavigationController(rootViewController: vc2)
        vc2.title = "Siti Web"
        self.addChild(nav2)
        
//        let vc3 = SocialVC()
//        let nav3 = UINavigationController(rootViewController: vc3)
//        nav3.navigationBar.prefersLargeTitles = true
//        nav3.navigationItem.title = "I nostri social"
//        vc3.title = "Social"
//        self.addChild(nav3)
        let vc3 = SocialVC()
        let nav3 = ThemedNavigationController(rootViewController: vc3)
        vc3.title = "Social"
        self.addChild(nav3)
        
        
        let vc4 = SettingsVC()
        vc4.title = "Impostazioni"
        let nav4 = ThemedNavigationController(rootViewController: vc4)
        self.addChild(nav4)
        
    }
    
//    private func presentSitoVC() {
//        let url = URL(string: "https://sites.google.com/salesiani.it/giopro/")!
//        let sitoVC = SFSafariViewController(url: url)
//        sitoVC.title = "Sito"
//        sitoVC.dismissButtonStyle = .close
//        DispatchQueue.main.async {
//            self.present(sitoVC, animated: true, completion: nil)
//        }
//    }
    
}

extension RootAppController : UITabBarControllerDelegate {
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if viewController is SitoVC {
//            self.presentSitoVC()
//            return false
//        }
//        return true
//    }
}
