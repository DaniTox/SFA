//
//  BasicCell.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class BasicCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        updateTheme()
    }
    
    private func updateTheme() {
        self.textLabel?.textColor = Theme.current.textColor
        self.backgroundColor = Theme.current.backgroundColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateTheme()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class SwitchCell : BasicCell {
    
    lazy var cellSwitch : UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cellSwitch)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        cellSwitch.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
