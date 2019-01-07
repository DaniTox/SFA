//
//  CompagniaDomandaCell.swift
//  SFA
//
//  Created by Dani Tox on 07/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class CompagniaDomandaCell: UITableViewCell {

    var mainLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(mainLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        mainLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
