//
//  SocialStack.swift
//  MGS
//
//  Created by Dani Tox on 29/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class SocialStack: UIView {
    
    var button: LocalizedButton!
    
    lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textColor = Theme.current.textColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    init(categoria: SitoCategoria) {
        self.button = LocalizedButton(category: categoria)
        super.init(frame: .zero)
        backgroundColor = .clear
    
        
        addSubview(button)
        addSubview(descriptionLabel)
        
        switch categoria {
        case .facebook: descriptionLabel.text = "Seguici su Facebook!"
        case .instagram: descriptionLabel.text = "#mgslombardiaemilia"
        case .youtube: descriptionLabel.text = "Guarda i nostri video!"
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
        button.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 7).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
}
