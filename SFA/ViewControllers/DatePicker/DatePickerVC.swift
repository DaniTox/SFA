//
//  DatePickerVC.swift
//  MGS
//
//  Created by Dani Tox on 24/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class DatePickerVC: UIViewController, HasCustomView {
    typealias CustomView = DatePickerView
    override func loadView() {
        self.view = CustomView()
    }
    
    public var currentDate: Date? {
        didSet {
            guard let date = currentDate else { return }
            DispatchQueue.main.async {
                self.rootView.picker.setDate(date, animated: true)
            }
        }
    }
    
    var maximumDate: Date
    
    var dateChangedHandler: ((Date) -> Void)
    
    init(maxDate: Date, dateChangedHandler: @escaping (Date) -> Void) {
        self.maximumDate = maxDate
        self.dateChangedHandler = dateChangedHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Data"
        
        rootView.picker.addTarget(self, action: #selector(dateDidChange(_:)), for: .valueChanged)
        
    }
    
    @objc func dateDidChange(_ sender: UIDatePicker) {
        dateChangedHandler(sender.date)
    }
    
}
