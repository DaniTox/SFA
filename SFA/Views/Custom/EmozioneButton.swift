//
//  EmozioneButton.swift
//  SFA
//
//  Created by Dani Tox on 03/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class EmozioneButton: UIButton {

    var emozione: Emozione! {
        didSet {
            self.updateEmozioneImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(.red, for: .normal)
        self.backgroundColor = UIColor.yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateEmozioneImage() {
        if emozione == nil { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            var title : String = ""
            
            switch self.emozione! {
            case .fiducioso:
                title = "Fiducia"
            case .aggressività:
                title = "Aggressività"
            case .paura:
                title = "Paura"
            case .tristezza:
                title = "Tristezza"
            case .gioia:
                title = "Gioia"
            case .equilibrio:
                title = "Equilibrio"
            }
            
            self.setTitle(title, for: .normal)
        }
    }
    
}
