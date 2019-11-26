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
    var controllers : [OrderedFlowController] = {
        if #available(iOS 13, *) {
            return [WelcomeVC(), GenderVC(), UserAgeVC(), NotificheVC(style: .grouped) ]
        } else {
            return [WelcomeVC(), GenderVC(), UserAgeVC(), ColorThemeVC(), NotificheVC(style: .grouped) ]
        }
    }()

    var terminateAction : ( () -> Void )?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.navigationBar.prefersLargeTitles = false
    }
    
    func start() {
        let vc = controllers.first!
        vc.orderingCoordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func next(from vc: UIViewController) {
        currentShowingControllerIndex = controllers.firstIndex(where: {$0 == vc}) ?? 0
        currentShowingControllerIndex += 1
        if currentShowingControllerIndex >= controllers.count {
            end()
        } else {
            let vc = controllers[currentShowingControllerIndex]
            vc.orderingCoordinator = self
            vc.showCurrentValue = false
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    private func end() {
        terminateAction?()
    }
    
}

extension OnboardingCoordinator : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if let index = controllers.firstIndex(where: { $0 == viewController }) {
            currentShowingControllerIndex = index
        }
    }
}
