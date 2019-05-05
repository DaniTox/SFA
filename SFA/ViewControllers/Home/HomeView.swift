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
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.8
        button.backgroundColor = .green
        
        //updateRDVTitle()
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
    
    lazy var gioProNetButton : UIBouncyButton = {
        let button = UIBouncyButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("GioProNet", for: .normal)
        button.backgroundColor = .red
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
        button.setTitle("Il mio percorso formativo", for: .normal)
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
        
        stackView.addArrangedSubview(noteButton)
        stackView.addArrangedSubview(compagniaButton)
        stackView.addArrangedSubview(teenStarButton)
        stackView.addArrangedSubview(gioProNetButton)
        stackView.addArrangedSubview(regolaButton)
        
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
    
    func updateRDVTitle() {
        switch User.currentUser().ageScuola {
        case .medie:
            regolaButton.setTitle("Agenda dell'allegria e della santità", for: .normal)
        case .biennio:
            regolaButton.setTitle("Il preogetto delle 3S", for: .normal)
        case .triennio:
            regolaButton.setTitle("Regola di Vita", for: .normal)
        }
    }
    
    func setBlocksAppearance(for type: ScuolaType) {
        if type == .medie {
            self.stackView.removeArrangedSubview(compagniaButton)
            compagniaButton.removeFromSuperview()
        } else {
            if !self.stackView.arrangedSubviews.contains(compagniaButton) {
                self.stackView.insertArrangedSubview(compagniaButton, at: 1)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


