//
//  SitoCell.swift
//  SFA
//
//  Created by Dani Tox on 22/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class SitoCell: BoldCell {

    lazy var nomeSitoLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        
        label.textColor = Theme.current.textColor
        return label
    }()
    
    lazy var urlLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        
        label.textColor = Theme.current.textColor
        return label
    }()
    
    var siteLabelsStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        siteLabelsStack.addArrangedSubview(nomeSitoLabel)
        siteLabelsStack.addArrangedSubview(urlLabel)
        
        containerView.addSubview(siteLabelsStack)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nomeSitoLabel.textColor = Theme.current.textColor
        urlLabel.textColor = Theme.current.textColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        siteLabelsStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        siteLabelsStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        siteLabelsStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 3).isActive = true
        siteLabelsStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
