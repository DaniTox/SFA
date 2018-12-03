//
//  OnBoardingView.swift
//  SFA
//
//  Created by Dani Tox on 14/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class OnBoardingView : UIView {
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Benvenuto nell'app MGS!"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var detailedLabel : UILabel = {
        let label = UILabel()
        label.text = "Seleziona la tua età per continuare:"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var ageLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "18"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var ageSlider : UISlider = {
        let slider = UISlider()
        slider.minimumValue = 10
        slider.maximumValue = 100
        slider.value = 18
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    var continueButton : UIButton = {
        let button = UIButton()
        button.setTitle("Continua", for: .normal)
        return button
    }()
    
    var ageStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    var containerAgeView : UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(detailedLabel)
        
        ageStack.addArrangedSubview(ageSlider)
        ageStack.addArrangedSubview(ageLabel)
        addSubview(ageStack)
        
       // addSubview(continueButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        
        detailedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100).isActive = true
        detailedLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        detailedLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        detailedLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        ageStack.topAnchor.constraint(equalTo: detailedLabel.bottomAnchor, constant: 20).isActive = true
        ageStack.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        ageStack.heightAnchor.constraint(equalToConstant: 70).isActive = true
        ageStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
