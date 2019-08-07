//
//  DatePickerModel.swift
//  SFA
//
//  Created by Dani Tox on 11/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class DatePickerModel {
    var completionDate : ((Date)->Void)?
    var viewController : UIViewController?
    
    lazy var datePicker : UIDatePicker = {
        let p = UIDatePicker()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.datePickerMode = .date
        p.date = Date()
        return p
    }()
    
    func loadDatePickerView() {
        guard let vcView = viewController?.view else { return }
        viewController?.view.addSubview(datePicker)
        datePicker.bottomAnchor.constraint(equalTo: vcView.bottomAnchor).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: vcView.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: vcView.trailingAnchor).isActive = true
    }
}
