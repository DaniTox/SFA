//
//  GenderVC.swift
//  SFA
//
//  Created by Dani Tox on 16/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GenderVC: UIViewController, HasCustomView, OrderedFlowController {
    typealias CustomView = GenderVCView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var orderingCoordinator: OrderedFlowCoordinator?
    var finishAction : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sesso"
        
        NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main) { (notification) in
            self.updateTheme()
        }
        
//        rootView.continueButton.addTarget(self, action: #selector(continueOnBoarding), for: .touchUpInside)
        
        rootView.maleButton.addTarget(self, action: #selector(maleTouched), for: .touchUpInside)
        rootView.girlButton.addTarget(self, action: #selector(girlTouched), for: .touchUpInside)
        
    }
    
    @objc private func maleTouched() {
        User.currentUser().gender = .boy
        workFinished()
    }
    
    @objc private func girlTouched() {
        User.currentUser().gender = .girl
        workFinished()
    }
    
    func workFinished() {
        orderingCoordinator?.next()
        finishAction?()
    }
    
    private func updateTheme() {
        rootView.backgroundColor = Theme.current.controllerBackground
    }
    
}
