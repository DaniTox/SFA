//
//  LocationCell.swift
//  MGS
//
//  Created by Dani Tox on 19/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class LocationCell: BoldCell {
    
    var loadingIndicator: UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView(style: (Theme.current is DarkTheme) ? .white : .gray)
        ind.translatesAutoresizingMaskIntoConstraints = false
        return ind
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.containerView.addSubview(loadingIndicator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        loadingIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loadingIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingIndicator.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
