//
//  SizeSliderAlert.swift
//  SFA
//
//  Created by Dani Tox on 31/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class SizeSliderAlert: UIView {
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Dimensione carattere: "
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
    
    lazy var slider : UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 1
        slider.maximumValue = 100
        return slider
    }()
    
    lazy var sliderLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .body).withSize(20)
        label.text = "100"
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var continueButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .purple
        button.titleLabel?.textColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continua", for: .normal)
        return button
    }()
    
    var completionHandler : ((Int) -> Void)?
    var newValueHandler : ((UIColor) -> Void)?

    var initialValue : Int
    
    init(frame: CGRect, initialValue : Int) {
        self.initialValue = initialValue
        super.init(frame: frame)
        slider.value = Float(initialValue)
        sliderValueChanged()
        
        containerView.addSubview(slider)
        containerView.addSubview(sliderLabel)
        addSubview(titleLabel)
        addSubview(containerView)
        addSubview(continueButton)
        
        continueButton.addTarget(self, action: #selector(finishWork), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    @objc private func sliderValueChanged() {
        let intValue = Int(slider.value)
        sliderLabel.text = "\(intValue)"
    }
    
    @objc private func finishWork() {
        let value = Int(slider.value)
        self.completionHandler?(value)
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
        
        slider.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        slider.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        slider.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8).isActive = true
        
        sliderLabel.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -25).isActive = true
        sliderLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
