//
//  WelcomeVC.swift
//  SFA
//
//  Created by Dani Tox on 21/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController, HasCustomView {
    typealias CustomView = WelcomeView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.backgroundColor = .orange
        
        rootView.registerButton.addTarget(self, action: #selector(registerAction(_:)), for: .touchUpInside)
        rootView.loginButton.addTarget(self, action: #selector(loginAction(_:)), for: .touchUpInside)
    }

    @objc func registerAction(_ sender: UIButton) {
        let vc = RegisterVC()
        let nav = RotationLogicNavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    
    @objc func loginAction(_ sender: UIButton) {
        let vc = LoginVC()
        let nav = RotationLogicNavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
}
