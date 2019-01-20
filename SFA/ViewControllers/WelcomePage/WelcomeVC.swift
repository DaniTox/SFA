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
    
    var pageViewController : WelcomePageVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Benvenuto in MGS!"
        rootView.backgroundColor = .orange
        
        rootView.registerButton.addTarget(self, action: #selector(registerAction(_:)), for: .touchUpInside)
        rootView.loginButton.addTarget(self, action: #selector(loginAction(_:)), for: .touchUpInside)
        rootView.ignoraButton.addTarget(self, action: #selector(ignoraAction(_:)), for: .touchUpInside)
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
    
    @objc func ignoraAction(_ sender: UIButton) {
        guard let nextController = pageViewController?.getControllerAt(index: 1) else { fatalError() }
        pageViewController?.setViewControllers([nextController], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        sender.isEnabled = false
    }
}
