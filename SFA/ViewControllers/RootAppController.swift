//
//  RootAppController.swift
//  SFA
//
//  Created by Dani Tox on 24/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class RootAppController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillController()
    }
    
    private func fillController() {
        let vc = HomeViewController()
        
        
//        let fileURL = Bundle.main.url(forResource: "regola", withExtension: "json")!
//        let data = try! Data(contentsOf: fileURL)
//        let regola = try! JSONDecoder().decode(Regola.self, from: data)

        let nav = UINavigationController(rootViewController: vc)
        
        //altri VCs
        
        
        self.addChild(nav)
    }
    
}
