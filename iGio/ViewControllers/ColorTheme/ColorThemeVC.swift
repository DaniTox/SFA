//
//  ColorThemeVC.swift
//  MGS
//
//  Created by Dani Tox on 24/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class ColorThemeVC: UIViewController, HasCustomView, OrderedFlowController {
    typealias CustomView = ColorThemeView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var showCurrentValue: Bool = true
    var orderingCoordinator: OrderedFlowCoordinator?
    var finishAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tema"
        
        rootView.darkThemeButton.addTarget(self, action: #selector(darkButtonPressed), for: .touchUpInside)
        rootView.lightThemeButton.addTarget(self, action: #selector(lightButtonPressed), for: .touchUpInside)
        if self.showCurrentValue {
            checkButton()
        }
    }
    
    func checkButton() {
        self.rootView.updateView()
    }
    
    @objc private func darkButtonPressed() {
        Theme.current = DarkTheme()
        updateTheme()
        
        workFinished()
        rootView.updateView()
    }
    
    @objc private func lightButtonPressed() {
        Theme.current = LightTheme()
        updateTheme()
        
        workFinished()
        
    }
    
    func workFinished() {
        orderingCoordinator?.next(from: self)
        finishAction?()
        checkButton()
    }
    
    private func updateTheme() {
        rootView.updateView()
        
    }
}
