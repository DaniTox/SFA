//
//  OnboardingCoordinator.swift
//  SFA
//
//  Created by Dani Tox on 16/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class OnboardingCoordinator: NSObject, OrderedFlowCoordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var currentShowingControllerIndex : Int = 0
    var controllers : [OrderedFlowController] = [
        WelcomeVC(),
        GenderVC(),
        GradoScuolaVC(),
        NotificheOnBoardingVC()
    ]

    var terminateAction : ( () -> Void )?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }
    
    func start() {
        let vc = controllers.first!
        vc.orderingCoordinator = self
        navigationController.pushViewController(vc as UIViewController, animated: false)
    }
    
    func next() {
        currentShowingControllerIndex += 1
        if currentShowingControllerIndex >= controllers.count {
            end()
        } else {
            let vc = controllers[currentShowingControllerIndex]
            vc.orderingCoordinator = self
            navigationController.pushViewController(vc as UIViewController, animated: true)
//            navigationController.navigationItem.backBarButtonItem?.isEnabled = false
        }
    }
    
    private func end() {
        terminateAction?()
    }
    
}

extension OnboardingCoordinator : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if let index = controllers.firstIndex(where: { ($0 as UIViewController) == (viewController) }) {
            currentShowingControllerIndex = index
        }
    }
}
