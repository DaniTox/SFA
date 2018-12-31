//
//  NoteCell.swift
//  SFA
//
//  Created by Dani Tox on 31/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    lazy var noteTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var noteDateLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(noteTitleLabel)
        addSubview(noteDateLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        noteTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        noteTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        noteTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        noteTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        noteDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        noteDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        noteDateLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        noteDateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
