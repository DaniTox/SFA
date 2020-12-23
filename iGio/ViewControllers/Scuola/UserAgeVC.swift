//
//  GradoScuolaVC.swift
//  SFA
//
//  Created by Dani Tox on 17/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class UserAgeVC: UIViewController, HasCustomView, OrderedFlowController {
    typealias CustomView = UserAgeView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var showCurrentValue: Bool = true
    var orderingCoordinator: OrderedFlowCoordinator?
    var finishAction : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Età"
        
        NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main) { (notification) in
            self.updateTheme()
        }
        
        rootView.medieButton.addTarget(self, action: #selector(medieTouched), for: .touchUpInside)
        rootView.biennioButton.addTarget(self, action: #selector(biennioTouched), for: .touchUpInside)
        rootView.triennioButton.addTarget(self, action: #selector(triennioTouched), for: .touchUpInside)
        
        if showCurrentValue {
            checkButton()
        }
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if orderingCoordinator != nil {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationItem.setHidesBackButton(false, animated: true)
        }
    }

    func checkButton() {
        self.rootView.updateView(for: GioUser.currentUser().scuolaType)
    }
    
    @objc private func medieTouched() {
        GioUser.currentUser().scuolaType = .medie
        workFinished()
        rootView.updateView(for: .medie)
    }
    
    @objc private func biennioTouched() {
        GioUser.currentUser().scuolaType = .biennio
        workFinished()
        rootView.updateView(for: .biennio)
    }
    
    @objc private func triennioTouched() {
        GioUser.currentUser().scuolaType = .triennio        
        workFinished()
        rootView.updateView(for: .triennio)
    }
    
    public func workFinished() {
        orderingCoordinator?.next(from: self)
        finishAction?()
    }
    
    private func updateTheme() {
        rootView.backgroundColor = Theme.current.controllerBackground
    }
    
    
}
