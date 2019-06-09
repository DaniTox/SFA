//
//  HomeItemCell.swift
//  MGS
//
//  Created by Dani Tox on 09/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class HomeItemCell: UICollectionViewCell {
    
    var item: HomeItem? {
        didSet {
            guard let item = item else { return }
            DispatchQueue.main.async {
                self.mainLabel.text = item.name
                self.iconView.image = item.image
                self.backgroundColor = item.color
            }
        }
    }
    
    lazy var mainLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.text = ""
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var iconView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        addSubview(mainLabel)
        addSubview(iconView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        mainLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        iconView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        iconView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45).isActive = true
        iconView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
