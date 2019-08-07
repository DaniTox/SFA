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
        self.setTitleColor(Theme.current.textColor, for: .normal)
        self.backgroundColor = Theme.current.backgroundColor
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
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
                title = "😌"
            case .aggressività:
                title = "😡"
            case .paura:
                title = "😱"
            case .tristezza:
                title = "😢"
            case .gioia:
                title = "😁"
            case .equilibrio:
                title = "😐"
            default:
                break
            }
            
            self.setTitle(title, for: .normal)
        }
    }
    
}
