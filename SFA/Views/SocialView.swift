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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(instagranmButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        instagranmButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        instagranmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        instagranmButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        instagranmButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
