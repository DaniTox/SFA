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
        let nav = UINavigationController(rootViewController: vc)
        self.addChild(nav)
        
        let vc2 = SitoVC()
        vc2.title = "Sito"
        self.addChild(vc2)
        
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
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if item.title == "Sito" {
//            presentSitoVC()
//            tabBarController?.selectedIndex = self.indexController
//        } else {
//            self.indexController = tabBarController?.selectedIndex ?? 0
//        }
//
//    }
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is SitoVC {
            self.presentSitoVC()
            return false
        }
        return true
    }
}
