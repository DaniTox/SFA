//
//  WelcomeVC.swift
//  SFA
//
//  Created by Dani Tox on 21/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController, HasCustomView, OrderedFlowController {
    typealias CustomView = WelcomeView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var showCurrentValue: Bool = true
    var orderingCoordinator: OrderedFlowCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Benvenuto in MGS!"
        rootView.backgroundColor = UIColor.black.lighter(by: 10)
        
        rootView.ignoraButton.addTarget(self, action: #selector(ignoraAction(_:)), for: .touchUpInside)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        rootView.ignoraButton.isEnabled = true
    }
    
    @objc func ignoraAction(_ sender: UIButton) {
        orderingCoordinator?.next()
    }
}
