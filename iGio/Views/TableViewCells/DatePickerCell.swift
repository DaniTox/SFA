//
//  DatePickerCell.swift
//  MGS
//
//  Created by Dani Tox on 28/03/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class DatePickerCell: BoldCell {
    
    var dateDidChange : ((Date) -> Void)?
    
    lazy var dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline).withSize(20)
        label.textColor = Theme.current.textColor
        label.textAlignment = .center
        label.text = "\(Date().stringValue)"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var datePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = UIDatePicker.Mode.date
        picker.date = Date()
        picker.maximumDate = Date()
        picker.setValue(Theme.current.textColor, forKeyPath: "textColor")
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        datePicker.addTarget(self, action: #selector(datePickerDidChangeValue(_:)), for: .valueChanged)
        
        containerView.addSubview(datePicker)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        datePicker.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func datePickerDidChangeValue(_ sender: UIDatePicker) {
        self.dateDidChange?(datePicker.date)
    }
}
