//
//  OnBoardingVC.swift
//  SFA
//
//  Created by Dani Tox on 14/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class OnBoardingVC : UIViewController, HasCustomView {
    typealias CustomView = OnBoardingView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.ageSlider.addTarget(self, action: #selector(sliderMoved(_:)), for: .valueChanged)
    }
    
    @objc private func sliderMoved(_ slider: UISlider) {
        let intValue = Int(slider.value)
        rootView.ageLabel.text = "\(intValue)"
    }
}
