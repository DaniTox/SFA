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
//        self.title = "Benvenuto in MGS!"
        if #available(iOS 13, *) {
            rootView.backgroundColor = Theme.current.controllerBackground
        } else {
            rootView.backgroundColor = LightTheme().backgroundColor
        }
        
        
        rootView.ignoraButton.addTarget(self, action: #selector(ignoraAction(_:)), for: .touchUpInside)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rootView.titleLabel.alpha = 0
        rootView.colorView.alpha = 0
        rootView.ignoraButton.alpha = 0
        rootView.descriptionLabel.alpha = 0
        
        rootView.titleLabel.center = rootView.center
        rootView.ignoraButton.center = rootView.center
        rootView.colorView.center = rootView.center
        rootView.descriptionLabel.center = rootView.center
        
        startAnimation()
    }
    
    func startAnimation() {

        rootView.allConstraints.forEach { $0.isActive = true }
        
        UIView.animate(withDuration: 3) {
            [
                self.rootView.titleLabel,
                self.rootView.colorView,
                self.rootView.descriptionLabel,
                self.rootView.ignoraButton
                ].forEach { $0.alpha = 1 }
            self.view.layoutIfNeeded()
        }
        
//        UIView.animate(withDuration: 1, delay: 1, options: UIView.AnimationOptions.curveEaseOut, animations: {
//            self.rootView.titleLabel.frame.y = self.rootView.frame.minY + 30
//            self.rootView.titleLabel.alpha = 1
//
//            self.rootView.colorView.alpha = 1
//            self.rootView.colorView.center.y = self.rootView.titleLabel.center.y + self.rootView.titleLabel.frame.height * 2
//        }) { _ in
//            UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseOut, animations: {
//                self.rootView.descriptionLabel.alpha = 1
//                self.rootView.descriptionLabel.center.y = self.rootView.colorView.center.y + self.rootView.colorView.frame.height + self.rootView.descriptionLabel.frame.height / 2
//
//            }) { _ in
//                UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseOut, animations: {
//                    self.rootView.ignoraButton.alpha = 1
//                    self.rootView.ignoraButton.frame.center.y = self.rootView.frame.bottom - self.rootView.ignoraButton.frame.height - 20
//                })
//            }
//        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        rootView.ignoraButton.isEnabled = true
    }
    
    @objc func ignoraAction(_ sender: UIButton) {
        orderingCoordinator?.next(from: self)
    }
}
