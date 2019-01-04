//
//  CicloColorCollectionCell.swift
//  SFA
//
//  Created by Dani Tox on 03/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class CicloColorCollectionCell: UICollectionViewCell {
    
    var cicloColor : CicloColor! {
        didSet {
            if cicloColor == nil { return }
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    var colorView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds =  true
        return view
    }()
    
    var descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .white
//        label.backgroundColor = .red
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(colorView)
        addSubview(descriptionLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        colorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        colorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        colorView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
        colorView.widthAnchor.constraint(equalTo: colorView.heightAnchor).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        colorView.layer.cornerRadius = colorView.frame.height / 2.0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateView() {
        var color : UIColor = UIColor.white
        switch self.cicloColor! {
        case .rosso:
            color = .red
        case .verde:
            color = .green
        case .giallo:
            color = .yellow
        case .bianco:
            color = .white
        case .croce:
            color = .black
        }
        self.colorView.backgroundColor = color
    }
    
}
