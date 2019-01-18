//
//  WelcomeView.swift
//  SFA
//
//  Created by Dani Tox on 18/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class WelcomeView: UIView {
    
    lazy var registerButton : UIBouncyButton = {
        let button = UIBouncyButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Iscriviti", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()

    lazy var loginButton : UIBouncyButton = {
        let button = UIBouncyButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Accedi", for: .normal)
        button.backgroundColor = UIColor.green.darker()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var ignoraButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ignora", for: .normal)
//        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Benvenuto in MGS!"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var buttonsStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 30
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttonsStack.addArrangedSubview(registerButton)
        buttonsStack.addArrangedSubview(loginButton)
        
        addSubview(titleLabel)
        addSubview(buttonsStack)
        addSubview(ignoraButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        buttonsStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        buttonsStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        buttonsStack.heightAnchor.constraint(equalToConstant: 250).isActive = true
        buttonsStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        
        ignoraButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        ignoraButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
