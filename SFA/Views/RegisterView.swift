//
//  RegisterView.swift
//  SFA
//
//  Created by Dani Tox on 26/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class RegisterView: UIView {

    var nomeField : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.placeholder = "Nome"
        return field
    }()
    
    var cognomeField : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.placeholder = "Cognome"
        return field
    }()
    
    var emailField : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.placeholder = "Email"
        return field
    }()
    
    var ageField : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.placeholder = "Età"
        return field
    }()
    
    var password1Field : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.placeholder = "Password"
        return field
    }()
    
    var password2Field : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.placeholder = "Ripeti la password"
        return field
    }()
    
    var fieldStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 20
        return stack
    }()
    
    lazy var registerButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Registrati", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .red
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    var fullStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 40
        return stack
    }()
    
    var loadingIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .orange
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadingIndicator.startAnimating()
        backgroundColor = .black
        
        fieldStack.addArrangedSubview(nomeField)
        fieldStack.addArrangedSubview(cognomeField)
        fieldStack.addArrangedSubview(ageField)
        fieldStack.addArrangedSubview(emailField)
        fieldStack.addArrangedSubview(password1Field)
        fieldStack.addArrangedSubview(password2Field)
        
        fullStack.addArrangedSubview(fieldStack)
        fullStack.addArrangedSubview(registerButton)
        
        addSubview(fullStack)
        addSubview(loadingIndicator)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //GLOBAL CONSTRAINTS
        registerButton.heightAnchor.constraint(lessThanOrEqualToConstant: 70).isActive = true
        fullStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fullStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingIndicator.topAnchor.constraint(equalTo: fullStack.bottomAnchor, constant: 20).isActive = true
        
        // IPAD CONSTRAINTS
        if UIDevice.current.deviceType == .pad {
            fieldStack.spacing = 35
            fullStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.55).isActive = true
            fullStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        } else {
        // IPHONE CONSTRAINTS
            fieldStack.spacing = 20
            fullStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
            fullStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
