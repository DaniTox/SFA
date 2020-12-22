//
//  AgeCell.swift
//  iGio
//
//  Created by Daniel Bazzani on 22/12/20.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

@available(iOS 14, *)
class AgeCell: BoldCell {
    var ageButton: UIButton = {
        let b = UIButton()
        b.setTitle(User.currentUser().ageScuola.settingsString, for: .normal)
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
                            UIAction(title: ScuolaType.medie.settingsString, handler: { (_) in
                                self.update(age: .medie)
                            }),
                            UIAction(title: ScuolaType.biennio.settingsString, handler: { (_) in
                                self.update(age: .biennio)
                            }),
                            UIAction(title: ScuolaType.triennio.settingsString, handler: { (_) in
                                self.update(age: .triennio)
                            })
        ])
        ageButton.menu = menu
        ageButton.showsMenuAsPrimaryAction = true
        
        self.addSubview(ageButton)
    }
    
    private func update(age: ScuolaType) {
        DispatchQueue.main.async {
            let realm = try! Realm()
            try? realm.write {
                User.currentUser().ageScuola = age
            }
            
            
            self.ageButton.setTitle(age.settingsString, for: .normal)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            ageButton.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            ageButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20),
            ageButton.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.5),
            ageButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
