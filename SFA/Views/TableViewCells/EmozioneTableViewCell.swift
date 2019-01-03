//
//  EmozioneTableViewCell.swift
//  SFA
//
//  Created by Dani Tox on 03/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class EmozioneTableViewCell: UITableViewCell {

    var touchedEmozione : Emozione?
    var emozioniButtons : [EmozioneButton] = []
    
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
        
        for (index, emozioneValue) in EMOZIONI.enumerated() {
            let button = EmozioneButton()
            button.emozione = Emozione.getEmozioneFrom(str: emozioneValue)
            button.addTarget(self, action: #selector(emozioneButtonWasTouched(_:)), for: .touchUpInside)
            
            if index <= 2 {
                emozioniUpStack.addArrangedSubview(button)
            } else {
                emozioniDownStack.addArrangedSubview(button)
            }
        }
        
        fullStack.addArrangedSubview(emozioniUpStack)
        fullStack.addArrangedSubview(emozioniDownStack)
        addSubview(fullStack)
    }
    
    @objc private func emozioneButtonWasTouched(_ sender: EmozioneButton) {
        self.touchedEmozione = sender.emozione
        print("Emozione premuta: \(String(describing: sender.emozione))")
        // - TODO: aggiungere qualche particolare grafico per fare in modo che si noti quale pulsante è attualmnte premuto. Togliere agli altri pulsanti quell'effetto grafico
        
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
