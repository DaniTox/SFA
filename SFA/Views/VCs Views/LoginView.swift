//
//  LoginView.swift
//  SFA
//
//  Created by Dani Tox on 23/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class LoginView: UIView {

    var emailField : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Email"
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.autocapitalizationType = .none
        return field
    }()
    
    var passwordField : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.borderStyle = UITextField.BorderStyle.roundedRect
        return field
    }()
    
    var fieldsStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    var fullStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 40
        return stack
    }()
    
    lazy var loginButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.backgroundColor = .green
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    var loadingIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .blue
        indicator.style = .whiteLarge
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        fieldsStack.addArrangedSubview(emailField)
        fieldsStack.addArrangedSubview(passwordField)

        fullStack.addArrangedSubview(fieldsStack)
        fullStack.addArrangedSubview(loginButton)
        
        addSubview(fullStack)
        addSubview(loadingIndicator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // GLOBAL CONSTRAINTS
        fullStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fullStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingIndicator.topAnchor.constraint(equalTo: fullStack.bottomAnchor, constant: 50).isActive = true
        
        let device = UIDevice.current.deviceType
        let orientation = UIDevice.current.orientation
        
        // IPAD CONSTRAINTS
        if device == .pad {
            
            emailField.heightAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
            passwordField.heightAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
            fieldsStack.spacing = 20
            
            if orientation == .portrait || orientation == .portraitUpsideDown {
                fullStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
                fullStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
                fullStack.spacing = 50
            } else {
                fullStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
                fullStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35).isActive = true
                fullStack.spacing = 50
            }
            
            
        } else {
        // IPHONE CONSTRAINTS
            emailField.heightAnchor.constraint(equalToConstant: 40).isActive = true
            passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
            fieldsStack.spacing = 20
            
            fullStack.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
            let heightFullStackConstraint = fullStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35)
            heightFullStackConstraint.priority = .defaultLow
            heightFullStackConstraint.isActive = true
            fullStack.spacing = 40
            
            loginButton.heightAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
