//
//  DatePickerView.swift
//  MGS
//
//  Created by Dani Tox on 24/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class DatePickerView: UIView {
    
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
        
        addSubview(picker)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        picker.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        picker.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        picker.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
