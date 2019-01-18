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
    public var domanda: CompagniaDomanda! {
        didSet {
            guard domanda != nil else { return }
            mainLabel.text = domanda.domanda
            if domanda.risposta < 0 { return }
            slider.value = Float(domanda.risposta)
            sliderLabel.text = "\(Int(slider.value))"
        }
    }
    
    public lazy var mainLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline).withSize(25)
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
        label.textColor = .white
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
    
    private var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .black
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.addSubview(mainLabel)
        sliderStack.addArrangedSubview(slider)
        sliderStack.addArrangedSubview(sliderLabel)
        containerView.addSubview(sliderStack)
        
        addSubview(containerView)
        
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
//        assert(domanda != nil)
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        self.sliderLabel.text = "\(Int(sender.value))"
        self.valueChanged?(Int(sender.value))
        self.domanda.risposta = Int16(sender.value)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        
        mainLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        mainLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.65).isActive = true
        
        sliderLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 70).isActive = true
        
        sliderStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 35).isActive = true
        sliderStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -35).isActive = true
        sliderStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        sliderStack.topAnchor.constraint(equalTo: mainLabel.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
