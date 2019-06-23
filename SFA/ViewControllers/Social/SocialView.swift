//
//  SocialView.swift
//  SFA
//
//  Created by Dani Tox on 06/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class SocialView: UIView {

    var instagranmButton : LocalizedButton = {
        let b = LocalizedButton(category: .instagram)
//        b.setTitle("Instagram", for: .normal)
        b.backgroundColor = .clear
//        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        b.translatesAutoresizingMaskIntoConstraints = false
        
        b.setImage(#imageLiteral(resourceName: "instagram"), for: .normal)
        b.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
//        b.layer.masksToBounds = true
        b.layer.cornerRadius = 10
        
        b.layer.shadowColor = UIColor.black.cgColor
        b.layer.shadowOffset = CGSize(width: 0, height: 0)
        b.layer.shadowOpacity = 1.0
        b.layer.shadowRadius = 10
        b.layer.masksToBounds = false
        return b
    }()
    
    var facebookButton : LocalizedButton = {
        let b = LocalizedButton(category: .facebook)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .clear
//        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
//        b.setTitle("Facebook", for: .normal)
        
        
        b.setImage(#imageLiteral(resourceName: "fb"), for: .normal)
        b.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        b.layer.cornerRadius = 10
        
        b.layer.shadowColor = UIColor.black.cgColor
        b.layer.shadowOffset = CGSize(width: 0, height: 0)
        b.layer.shadowOpacity = 1.0
        b.layer.shadowRadius = 10
        b.layer.masksToBounds = false
        return b
    }()
    
    var youtubeButton : LocalizedButton = {
        let b = LocalizedButton(category: .youtube)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.clear
//        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
//        b.setTitle("YouTube", for: .normal)
        
        b.setImage(#imageLiteral(resourceName: "youtube"), for: .normal)

        b.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        b.layer.cornerRadius = 10
        
        b.layer.shadowColor = UIColor.black.cgColor
        b.layer.shadowOffset = CGSize(width: 0, height: 0)
        b.layer.shadowOpacity = 1.0
        b.layer.shadowRadius = 10
        b.layer.masksToBounds = false
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
        backgroundColor = Theme.current.controllerBackground
//        backgroundColor = UIColor.black.lighter(by: 10)
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
