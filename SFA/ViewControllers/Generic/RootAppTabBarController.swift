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
    }
    
    private func fillController() {
        let vc = HomeViewController()
        let nav1 = UINavigationController(rootViewController: vc)
        self.addChild(nav1)
        
        let vc2 = SitoVC()
        vc2.title = "Sito"
        self.addChild(vc2)
        
        let vc3 = SocialVC()
        vc3.title = "Social"
        self.addChild(vc3)
        
        let vc4 = SettingsVC()
        vc4.title = "Impostazioni"
        let nav4 = UINavigationController(rootViewController: vc4)
        self.addChild(nav4)
        
    }
    
    private func presentSitoVC() {
        let url = URL(string: "https://sites.google.com/salesiani.it/giopro/")!
        let sitoVC = SFSafariViewController(url: url)
        sitoVC.title = "Sito"
        sitoVC.dismissButtonStyle = .close
        DispatchQueue.main.async {
            self.present(sitoVC, animated: true, completion: nil)
        }
    }
    
}

extension RootAppController : UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is SitoVC {
            self.presentSitoVC()
            return false
        }
        return true
    }
}
