//
//  UIBox.swift
//  SFA
//
//  Created by Dani Tox on 16/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class UIBox: UIView {
    
    public var boxTouched : (() -> Void)?
    private var tapGestureRecognizer : UITapGestureRecognizer?// UITapGestureRecognizer(target: self, action: #selector(viewTapped))
    
    public var mainLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.addGestureRecognizer(tapGestureRecognizer!)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.green.darker()?.cgColor
        
        addSubview(mainLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    @objc private func viewTapped() {
        self.boxTouched?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    public func selectBox() {
        self.layer.borderWidth = 10
    }
    
    public func unselectBox() {
        self.layer.borderWidth = 0
    }
    
}
