//
//  ColorSliderAlert.swift
//  SFA
//
//  Created by Daniel Fortesque on 31/12/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit
import ColorSlider

class ColorSliderAlert: UIView {
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Seleziona il colore"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        label.textAlignment = .center
        return label
    }()
    
    lazy var containerView : UIView = {
        let container = UIView()
        container.backgroundColor = .gray
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var colorSlider : ColorSlider = {
        let slider = ColorSlider(orientation: Orientation.horizontal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    lazy var continueButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.titleLabel?.textColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continua", for: .normal)
        return button
    }()
    
    var completionHandler : ((UIColor) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        containerView.addSubview(colorSlider)

        addSubview(titleLabel)
        addSubview(containerView)
        addSubview(continueButton)
        
        continueButton.addTarget(self, action: #selector(finishWork), for: .touchUpInside)
    }

    
    @objc private func finishWork() {
        let color = colorSlider.color
        completionHandler?(color)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.23).isActive = true
        
        continueButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: continueButton.topAnchor).isActive = true
        
        colorSlider.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        colorSlider.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        colorSlider.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8).isActive = true
        colorSlider.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
