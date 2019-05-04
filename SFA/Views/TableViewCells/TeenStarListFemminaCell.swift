//
//  CicloTableViewCell.swift
//  SFA
//
//  Created by Dani Tox on 03/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

let DEFAULT_CICLO_CELL_COLOR = UIColor.black.lighter(by: 8)!
let SELECTED_CICLO_CELL_COLOR = UIColor.orange//UIColor.green.darker(by: 20)!

class TeenStarListFemminaCell: BoldCell {
    
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Theme.current.textColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var fullStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        fullStack.addArrangedSubview(colorView)
        fullStack.addArrangedSubview(descriptionLabel)
        
        containerView.addSubview(dateLabel)
        containerView.addSubview(fullStack)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.2).isActive = true
        
        colorView.widthAnchor.constraint(equalTo: fullStack.heightAnchor).isActive = true
        
        fullStack.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        fullStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        fullStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true
        fullStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(color: CicloColor) {
        self.colorView.backgroundColor = color.getViewColor()
        self.descriptionLabel.text = color.getDescriptionText()
    }
}
