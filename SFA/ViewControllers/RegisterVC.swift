//
//  RegisterVC.swift
//  SFA
//
//  Created by Dani Tox on 24/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController, HasCustomView {
    typealias CustomView = RegisterView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registrazione"
        
        enableAutoHideKeyboardAfterTouch(in: [rootView, rootView.registerButton])
        
        let backButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backAction))
        navigationItem.setLeftBarButton(backButton, animated: true)
    }
    
    @objc private func backAction() {
        dismiss(animated: true, completion: nil)
    }

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        rootView.removeConstraints(rootView.constraints)
        rootView.setNeedsLayout()
    }
    
}
