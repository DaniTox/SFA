//
//  TextEditingBottomBar.swift
//  SFA
//
//  Created by Dani Tox on 31/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit
import ColorSlider

class TextEditingBottomBar: UIView {

    var textView: UITextView
    
    lazy var colorSlider : ColorSlider = {
        let slider = ColorSlider(orientation: Orientation.horizontal, previewView: nil)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    lazy var sizeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setTitle("Colore", for: .normal)
        button.titleLabel?.textColor = .white
        return button
    }()
    
    lazy var colorButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setTitle("Dimensione", for: .normal)
        button.titleLabel?.textColor = .white
        return button
    }()
    
    lazy var buttonsStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = UIStackView.Alignment.center
        stack.distribution = UIStackView.Distribution.fillEqually
        return stack
    }()
    
    init(textView: UITextView, frame: CGRect) {
        self.textView = textView
        super.init(frame: frame)
        
        buttonsStack.addArrangedSubview(colorButton)
        buttonsStack.addArrangedSubview(sizeButton)
        addSubview(buttonsStack)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        buttonsStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        buttonsStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
//        let half = self.frame.width / CGFloat(buttonsStack.arrangedSubviews.count)
        buttonsStack.spacing = 10
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
