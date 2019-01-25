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
//            var color: UIColor = UIColor.clear
            
            switch self.emozione! {
            case .fiducioso:
                title = "😌"
//                color = UIColor.blue.lighter(by: 10)!
            case .aggressività:
                title = "😡"
//                color = UIColor.red
            case .paura:
                title = "😱"
//                color = UIColor.purple
            case .tristezza:
                title = "😢"
//                color = UIColor.gray
            case .gioia:
                title = "😁"
//                color = UIColor.green.darker(by: 20)!
            case .equilibrio:
                title = "😐"
//                color = UIColor.yellow.darker()!
            }
            
            self.setTitle(title, for: .normal)
//            self.backgroundColor = color
        }
    }
    
}
