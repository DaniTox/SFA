//
//  DatePickerView.swift
//  MGS
//
//  Created by Dani Tox on 24/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class DatePickerView: UIView {
    
    private var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.cornerRadius = 10
        
        view.backgroundColor = Theme.current.backgroundColor
        
        view.layer.shadowColor = Theme.current.shadowColor.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 10
        view.layer.masksToBounds = false
        return view
    }()
    
    var picker: UIDatePicker = {
        let pick = UIDatePicker(frame: .zero)
        pick.translatesAutoresizingMaskIntoConstraints = false
        pick.datePickerMode = UIDatePicker.Mode.date
        pick.maximumDate = Date()
        pick.setValue(Theme.current.textColor, forKeyPath: "textColor")
        return pick
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Theme.current.controllerBackground
        
        addSubview(containerView)
        containerView.addSubview(picker)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        
        
        picker.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        picker.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
