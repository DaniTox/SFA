//
//  EmozioneTableViewCell.swift
//  SFA
//
//  Created by Dani Tox on 03/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class EmozioneTableViewCell: BoldCell {

    var emozioneSelected : Emozione?
    var emozioniButtons : [EmozioneButton] = []
    var newValueSelected : ((Emozione)-> Void)?
    
    var emozioniUpStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    var emozioniDownStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    var fullStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        for (index, emozioneValue) in EMOZIONI.enumerated() {
            let button = EmozioneButton()
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 10
            button.layer.borderColor = UIColor.orange.cgColor

            
            button.emozione = Emozione.getEmozioneFrom(str: emozioneValue)
            button.addTarget(self, action: #selector(emozioneButtonWasTouched(_:)), for: .touchUpInside)
            
            if index <= 2 {
                emozioniUpStack.addArrangedSubview(button)
            } else {
                emozioniDownStack.addArrangedSubview(button)
            }
            emozioniButtons.append(button)
        }
        
        fullStack.addArrangedSubview(emozioniUpStack)
        fullStack.addArrangedSubview(emozioniDownStack)
        addSubview(fullStack)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.emozioniButtons.forEach({$0.backgroundColor = Theme.current.backgroundColor })
    }
    
    public func select(newEmotion: Emozione) {
        emozioniButtons.forEach { (button) in
            if button.emozione == newEmotion {
//                button.layer.borderWidth = 8
                button.backgroundColor = UIColor.green.darker()
            } else {
//                button.layer.borderWidth = 0
                button.backgroundColor = Theme.current.backgroundColor
            }
        }
    }
    
    @objc private func emozioneButtonWasTouched(_ sender: EmozioneButton) {
        self.newValueSelected?(sender.emozione)
        self.emozioneSelected = sender.emozione
        select(newEmotion: sender.emozione)
        print("Emozione premuta: \(String(describing: sender.emozione))")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fullStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fullStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        fullStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85).isActive = true
        fullStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
