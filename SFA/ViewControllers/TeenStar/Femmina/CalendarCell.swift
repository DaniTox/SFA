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
    
    var circleView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.masksToBounds = true
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(dayLabel)
        addSubview(circleView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        dayLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        dayLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
        
        circleView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        circleView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        circleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        circleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        circleView.layer.cornerRadius = circleView.frame.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
