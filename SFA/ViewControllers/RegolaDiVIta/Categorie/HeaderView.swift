//
//  HeaderView.swift
//  MGS
//
//  Created by Dani Tox on 08/04/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class HeaderView : UIView {
    
    lazy var mainLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mainLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        mainLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
}
