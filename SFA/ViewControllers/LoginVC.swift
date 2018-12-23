//
//  LoginVC.swift
//  SFA
//
//  Created by Dani Tox on 21/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, HasCustomView {
    typealias CustomView = LoginView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        
        enableAutoHideKeyboardAfterTouch(in: [rootView])
        
        let backButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backAction))
        navigationItem.setLeftBarButton(backButton, animated: true)
    }
    
    
    
    @objc private func backAction() {
        dismiss(animated: true, completion: nil)
    }
}
