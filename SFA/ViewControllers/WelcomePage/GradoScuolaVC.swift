//
//  GradoScuolaVC.swift
//  SFA
//
//  Created by Dani Tox on 17/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GradoScuolaVC: UIViewController, HasCustomView, OrderedFlowController {
    typealias CustomView = GradoScuolaView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var orderingCoordinator: OrderedFlowCoordinator?
    var finishAction : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Scuola"
        
        NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main) { (notification) in
            self.updateTheme()
        }
        
        rootView.medieButton.addTarget(self, action: #selector(medieTouched), for: .touchUpInside)
        rootView.superioriButton.addTarget(self, action: #selector(superioriTouched), for: .touchUpInside)
    }

    @objc private func medieTouched() {
        gradoScuolaSaved = .medie
        workFinished()
    }
    
    @objc private func superioriTouched() {
        gradoScuolaSaved = .superiori
        workFinished()
    }
    
    public func workFinished() {
        orderingCoordinator?.next()
        finishAction?()
    }
    
    private func updateTheme() {
        rootView.backgroundColor = Theme.current.tableViewBackground
    }
    
    
}
