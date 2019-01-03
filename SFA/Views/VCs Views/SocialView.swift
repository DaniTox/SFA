//
//  SocialView.swift
//  SFA
//
//  Created by Dani Tox on 06/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class SocialView: UIView {

    var instagranmButton : UIButton = {
        let b = UIButton()
        b.setTitle("Instagram", for: .normal)
        b.backgroundColor = .red
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    var facebookButton : UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .blue
        b.setTitle("Facebook", for: .normal)
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(instagranmButton)
        addSubview(facebookButton   )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        instagranmButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        instagranmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        instagranmButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        instagranmButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        facebookButton.topAnchor.constraint(equalTo: instagranmButton.bottomAnchor).isActive = true
        facebookButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        facebookButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        facebookButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
