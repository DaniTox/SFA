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
        return field
    }()
    
    var passwordField : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Password"
        field.borderStyle = UITextField.BorderStyle.roundedRect
        return field
    }()
    
    var fieldsStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 20
        return stack
    }()
    
    var fullStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 50
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        fieldsStack.addArrangedSubview(emailField)
        fieldsStack.addArrangedSubview(passwordField)

        fullStack.addArrangedSubview(fieldsStack)
        fullStack.addArrangedSubview(loginButton)
        
        addSubview(fullStack)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        emailField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginButton.heightAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        
        
        fullStack.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        fullStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 250).isActive = true
        fullStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fullStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
