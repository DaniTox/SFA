//
//  CompagniaDomandaCell.swift
//  SFA
//
//  Created by Dani Tox on 07/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class CompagniaDomandaCell: UITableViewCell {
    

    public var valueChanged : ((Int) -> Void)?
    public var domanda: VerificaDomanda! {
        didSet {
            guard domanda != nil else { return }
            DispatchQueue.main.async {
                self.mainLabel.text = self.domanda.domanda
                if self.domanda.risposta < 0 { return }
                self.slider.value = Float(self.domanda.risposta)
                self.sliderLabel.text = "\(Int(self.slider.value))"
                
                let integerValue = self.domanda.risposta
                self.slider.setThumbImage(self.getThumbImage(from: integerValue), for: .normal)
                self.slider.setThumbImage(self.getThumbImage(from: integerValue), for: .highlighted)
            }
        }
    }
    
    public lazy var mainLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.current.textColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).withSize(20)
        return label
    }()
    
    public lazy var slider : UISlider = {
        let slider = UISlider()
        slider.maximumValue = 10
        slider.value = 0
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = .green
        return slider
    }()
    
    private lazy var sliderLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.current.textColor
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
    
    private var containerView : BouncyView = {
        let view = BouncyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        view.backgroundColor = Theme.current.backgroundColor
        
        view.layer.shadowColor = Theme.current.shadowColor.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 10
        view.layer.masksToBounds = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.addSubview(mainLabel)
        sliderStack.addArrangedSubview(slider)
        sliderStack.addArrangedSubview(sliderLabel)
        containerView.addSubview(sliderStack)
        
        contentView.addSubview(containerView)
        backgroundColor = .clear
        selectionStyle = .none
        
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
//        assert(domanda != nil)
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        sender.value = roundf(sender.value)
        
        let integerValue = Int(roundf(sender.value))
        
        self.sliderLabel.text = "\(Int(sender.value))"
        self.slider.setThumbImage(getThumbImage(from: integerValue), for: .normal)
        self.slider.setThumbImage(self.getThumbImage(from: integerValue), for: .highlighted)
        
        self.valueChanged?(Int(sender.value))
        let realm = try! Realm()
        try? realm.write {
            self.domanda.risposta = Int(sender.value)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margins = contentView.layoutMarginsGuide
        
        containerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 5).isActive = true
        containerView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -5).isActive = true
        
        mainLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        mainLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.65).isActive = true
        
        sliderLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        
        sliderStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 35).isActive = true
        sliderStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -35).isActive = true
        sliderStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        sliderStack.topAnchor.constraint(equalTo: mainLabel.bottomAnchor).isActive = true
    }
    
    private func getThumbImage(from integer: Int) -> UIImage? {
        //🙁 0-1
        //😐 2-3-4
        //😌 5-6
        //😃 7-8
        //😁 9-10
        switch integer {
        case 0, 1:
            return "🙁".image(with: 30)
        case 2, 3, 4:
            return "😐".image(with: 30)
        case 5, 6:
            return "😌".image(with: 30)
        case 7, 8:
            return "😃".image(with: 30)
        case 9, 10:
            return "😁".image(with: 30)
        default:
            return "".image()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
