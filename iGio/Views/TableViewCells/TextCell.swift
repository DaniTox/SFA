//
//  TextCell.swift
//  SFA
//
//  Created by Dani Tox on 23/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class TextCell: BoldCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.mainLabel.textColor = Theme.current.cellSubtitleColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.mainLabel.textColor = Theme.current.cellSubtitleColor
    }

}
