//
//  WelcomeVC.swift
//  SFA
//
//  Created by Dani Tox on 21/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func registerAction(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Register", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "registerNav")
        let vc = RegisterVC()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    
    @IBAction func loginAction(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Login", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "loginNav")
        let vc = LoginVC()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
}
