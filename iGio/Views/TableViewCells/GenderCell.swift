//
//  GenderCell.swift
//  iGio
//
//  Created by Daniel Bazzani on 22/12/20.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

@available(iOS 14, *)
class GenderCell: BoldCell {
    var genderButton: UIButton = {
        let b = UIButton()
        b.setTitle(GioUser.currentUser().gender.stringValue, for: .normal)
        b.setTitleColor(Theme.current.textColor, for: .normal)
        b.layer.cornerRadius = 5
        b.layer.borderWidth = 1
        b.layer.borderColor = Theme.current.textColor.cgColor
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let menu = UIMenu(title: "",
                          options: .displayInline,
                          children: [
                            UIAction(title: UserGender.boy.stringValue, handler: { (_) in
                                self.update(gender: .boy)
                            }),
                            UIAction(title: UserGender.girl.stringValue, handler: { (_) in
                                self.update(gender: .girl)
                            })
        ])
        genderButton.menu = menu
        genderButton.showsMenuAsPrimaryAction = true
        
        self.addSubview(genderButton)
    }
    
    private func update(gender: UserGender) {
        DispatchQueue.main.async {
            GioUser.currentUser().gender = gender
            
            self.genderButton.setTitle(gender.stringValue, for: .normal)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            genderButton.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            genderButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20),
            genderButton.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.5),
            genderButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
