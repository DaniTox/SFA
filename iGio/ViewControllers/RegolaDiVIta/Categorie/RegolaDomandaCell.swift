//
//  RegolaDomandaCell.swift
//  MGS
//
//  Created by Dani Tox on 28/04/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class RegolaDomandaCell: UITableViewCell {
    
    lazy var mainLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = Theme.current.textColor
        return label
    }()
    
    lazy var answerLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Theme.current.cellSubtitleColor
        return label
    }()
    
    lazy var rightBottomLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.preferredFont(forTextStyle: .body).withSize(14)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textColor = Theme.current.textColor
        return label
    }()
    
    lazy var containerView : BouncyView = {
        let view = BouncyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        //        view.backgroundColor = UIColor.black.lighter(by: 10)
        view.backgroundColor = Theme.current.backgroundColor
        
        view.layer.shadowColor = Theme.current.shadowColor.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 10
        view.layer.masksToBounds = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        containerView.addSubview(mainLabel)
        containerView.addSubview(answerLabel)
        if UIDevice.current.deviceType == .pad {
            contentView.addSubview(containerView)
        } else {
            addSubview(containerView)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = contentView.layoutMarginsGuide
        if UIDevice.current.deviceType == .pad {
            containerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 5).isActive = true
            containerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -5).isActive = true
            containerView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -5).isActive = true
            containerView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 5).isActive = true
        } else {
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        }
        
        
        mainLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        mainLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
        mainLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        
        
        answerLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        answerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        answerLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        answerLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainLabel.textColor = Theme.current.textColor
        rightBottomLabel.textColor = Theme.current.textColor
        answerLabel.textColor = Theme.current.cellSubtitleColor
        containerView.backgroundColor = Theme.current.backgroundColor
        containerView.layer.shadowColor = Theme.current.shadowColor.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

