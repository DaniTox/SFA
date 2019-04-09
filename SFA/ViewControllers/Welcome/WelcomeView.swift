//
//  WelcomeView.swift
//  SFA
//
//  Created by Dani Tox on 18/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class WelcomeView: UIView {
        
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(ignoraButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ignoraButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        ignoraButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
