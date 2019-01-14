//
//  CompagniaDomandaCell.swift
//  SFA
//
//  Created by Dani Tox on 07/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class CompagniaDomandaCell: UITableViewCell {

    public var valueChanged : ((Int) -> Void)?
    
    public lazy var mainLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    public lazy var slider : UISlider = {
        let slider = UISlider()
        slider.maximumValue = 100.0
        slider.value = 0.0
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var sliderLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFont.preferredFont(forTextStyle: .body).withSize(20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var sliderStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(mainLabel)
        sliderStack.addArrangedSubview(slider)
        sliderStack.addArrangedSubview(sliderLabel)
        addSubview(sliderStack)
        
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        self.sliderLabel.text = "\(Int(sender.value))"
        self.valueChanged?(Int(sender.value))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        mainLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.65).isActive = true
        
        sliderLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 70).isActive = true
        
        sliderStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        sliderStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        sliderStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        sliderStack.topAnchor.constraint(equalTo: mainLabel.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
