//
//  WelcomePageVC.swift
//  SFA
//
//  Created by Dani Tox on 21/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class WelcomePageVC: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        guard let firstVC = orderedViewControllers.first else { return }
        setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
    }
    
    private(set) lazy var orderedViewControllers : [UIViewController] = {
        let vcs = [self.getController(withIdentifier: "welcomeVC", storyboardName: "WelcomeVC"),
                   self.getController(withIdentifier: "notificheVC", storyboardName: "NotificheVC")]
        return vcs
    }()

    private func getController(withIdentifier identifier: String, storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
}

extension WelcomePageVC : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard orderedViewControllers.count > previousIndex else { return nil }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = vcIndex + 1
        let vcsCount = orderedViewControllers.count
        
        guard vcsCount != nextIndex else { return nil }
        guard vcsCount > nextIndex else { return nil }
        return orderedViewControllers[nextIndex]
    }
    
    
}
