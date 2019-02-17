//
//  HomeView.swift
//  SFA
//
//  Created by Dani Tox on 17/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class HomeView : UIView {
    
    lazy var regolaButton : UIBouncyButton = {
        let button = UIBouncyButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Regola di Vita", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.8
        button.backgroundColor = .green
        
        //        button.layer.masksToBounds = true
        //        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var noteButton : UIBouncyButton = {
        let button = UIBouncyButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Diario personale", for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.8
        
        //        button.layer.masksToBounds = true
        //        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var teenStarButton : UIBouncyButton = {
        let button = UIBouncyButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("TeenSTAR", for: .normal)
        button.backgroundColor = .purple
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.8
        
        //        button.layer.masksToBounds = true
        //        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var compagniaButton : UIBouncyButton = {
        let button = UIBouncyButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Compagnia", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.8
        
        //        button.layer.masksToBounds = true
        //        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0 //30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Theme.current.controllerBackground
        stackView.addArrangedSubview(regolaButton)
        stackView.addArrangedSubview(noteButton)
        stackView.addArrangedSubview(teenStarButton)
        stackView.addArrangedSubview(compagniaButton)
        addSubview(stackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        //        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        //        stackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.70).isActive = true
        //        stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


