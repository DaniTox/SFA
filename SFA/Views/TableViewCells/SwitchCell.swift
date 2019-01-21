//
//  SwitchCell.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class SwitchCell : BoldCell {
    
    lazy var cellSwitch : UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        
        
        containerView.addSubview(cellSwitch)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellSwitch.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        cellSwitch.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        
//        if UIDevice.current.deviceType == .pad {
//            let margins = contentView.layoutMarginsGuide
//            cellSwitch.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
//            cellSwitch.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
//        } else {
//            cellSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
//            cellSwitch.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
