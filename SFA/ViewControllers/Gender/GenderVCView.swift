//
//  GenderVCView.swift
//  SFA
//
//  Created by Dani Tox on 16/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GenderVCView: UIView {
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = Theme.current.textColor
        label.textAlignment = .center
        label.text = "Sei maschio o femmina?"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var maleButton : UIBouncyButton = {
        let button = UIBouncyButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Maschio", for: .normal)
        button.setTitleColor(Theme.current.textColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = Theme.current.backgroundColor
        
        //        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.layer.shadowColor = Theme.current.shadowColor.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10
        button.layer.masksToBounds = false
        return button
    }()
    
    
    lazy var girlButton : UIBouncyButton = {
        let button = UIBouncyButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Femmina", for: .normal)
        button.setTitleColor(Theme.current.textColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = Theme.current.backgroundColor
        
        //        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.layer.shadowColor = Theme.current.shadowColor.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10
        button.layer.masksToBounds = false
        return button
    }()
    
    private var boxesStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 20
        return stack
    }()
    
    var fullStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 20
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Theme.current.controllerBackground
        
        boxesStack.addArrangedSubview(maleButton)
        boxesStack.addArrangedSubview(girlButton)
        
        fullStack.addArrangedSubview(titleLabel)
        fullStack.addArrangedSubview(boxesStack)
        
        addSubview(fullStack)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fullStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fullStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        fullStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75).isActive = true
        fullStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
    }
    
    func updateView(for gender: UserGender) {
        if gender == .boy {
            maleButton.backgroundColor = .green
            girlButton.backgroundColor = Theme.current.backgroundColor
        } else {
            maleButton.backgroundColor = Theme.current.backgroundColor
            girlButton.backgroundColor = .green
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
