//
//  SocialView.swift
//  SFA
//
//  Created by Dani Tox on 06/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class SocialView: UIView {

    var instagranmButton : UIBouncyButton = {
        let b = UIBouncyButton()
        b.setTitle("Instagram", for: .normal)
        b.backgroundColor = .purple
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        b.translatesAutoresizingMaskIntoConstraints = false
        
        b.layer.masksToBounds = true
        b.layer.cornerRadius = 10
        return b
    }()
    
    var facebookButton : UIBouncyButton = {
        let b = UIBouncyButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .blue
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        b.setTitle("Facebook", for: .normal)
        
        b.layer.masksToBounds = true
        b.layer.cornerRadius = 10
        return b
    }()
    
    var youtubeButton : UIBouncyButton = {
        let b = UIBouncyButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.red
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        b.setTitle("YouTube", for: .normal)
        
        b.layer.masksToBounds = true
        b.layer.cornerRadius = 10
        return b
    }()
    
    var stackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 25
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stackView.addArrangedSubview(facebookButton)
        stackView.addArrangedSubview(instagranmButton)
        stackView.addArrangedSubview(youtubeButton)
        
        addSubview(stackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
