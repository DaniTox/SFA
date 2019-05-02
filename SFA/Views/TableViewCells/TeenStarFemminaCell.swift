//
//  TeenStarFemminaListCell.swift
//  MGS
//
//  Created by Dani Tox on 01/05/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class TeenStarFemminaCell : BoldCell {
    
    var colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Theme.current.textColor
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(colorView)
        addSubview(descriptionLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        colorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        colorView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 10).isActive = true
        colorView.widthAnchor.constraint(equalTo: colorView.heightAnchor).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    func set(color: CicloColor) {
        self.colorView.backgroundColor = color.getViewColor()
        self.descriptionLabel.text = color.getDescriptionText()
    }
}
