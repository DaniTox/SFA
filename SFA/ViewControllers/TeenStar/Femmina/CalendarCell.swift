//
//  CalendarCell.swift
//  MGS
//
//  Created by Dani Tox on 29/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    lazy var dayLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Theme.current.textColor
        label.textAlignment = .left
        label.text = ""
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(dayLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dayLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        dayLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dayLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
