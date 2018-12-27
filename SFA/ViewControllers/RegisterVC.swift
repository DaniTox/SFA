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
    
    let model = NetworkAgent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registrazione"
        
        enableAutoHideKeyboardAfterTouch(in: [rootView, rootView.registerButton])
        
        rootView.registerButton.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        
        let backButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backAction))
        navigationItem.setLeftBarButton(backButton, animated: true)
        
        model.errorHandler = { [weak self] (errorString) in
            self?.showError(withTitle: "Errore", andMessage: errorString) // FUNC ALREADY IN MAIN QUEUE
        }
    }
    
    @objc private func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func registerAction() {
        let nome = rootView.nomeField.text ?? ""
        let cognome = rootView.cognomeField.text ?? ""
        let email = rootView.emailField.text ?? ""
        let age = rootView.ageField.text ?? ""
        let password1 = rootView.password1Field.text ?? ""
        let password2 = rootView.password2Field.text ?? ""
        
        let allFields : [(String, UITextField)] = [(nome, rootView.nomeField),
                                                   (cognome, rootView.cognomeField),
                                                   (email, rootView.emailField),
                                                   (age, rootView.ageField),
                                                   (password1, rootView.password1Field),
                                                   (password2, rootView.password2Field)]
        
        var isGoodToContinue: Bool = true
        allFields.forEach { (nameField, field) in
            if nameField.isEmpty {
                field.backgroundColor = .red
                isGoodToContinue = false
            } else {
                field.backgroundColor = .white
            }
        }
        
        if isGoodToContinue == false {
            model.errorHandler?("Scrivi tutti i campi necessari e riprova")
            return
        }
        
        guard let ageInt = Int(age) else {
            model.errorHandler?("L'età che hai inserito non è un numero intero")
            rootView.ageField.backgroundColor = .red
            return
        }
        
        rootView.ageField.backgroundColor = .white
        
        
        if password1 != password2 {
            model.errorHandler?("Le due password non corrispondono")
            rootView.password1Field.backgroundColor = .red
            rootView.password2Field.backgroundColor = .red
            return
        } else {
            rootView.password1Field.backgroundColor = .white
            rootView.password2Field.backgroundColor = .white
        }
        
        
        let user = User()
        user.name = nome
        user.cognome = cognome
        user.age = ageInt
        user.email = email
        user.password = password1
        
        model.register(user: user) { [weak self] in
            self?.showAlert(withTitle: "Successo!", andMessage: "La registrazione è stata eseguita con successo!")
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        rootView.removeConstraints(rootView.constraints)
        rootView.setNeedsLayout()
    }
    
}
