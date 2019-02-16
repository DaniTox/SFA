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
        let vc1 = WelcomeVC()
        vc1.pageViewController = self
        let nav1 = UINavigationController(rootViewController: vc1)
        nav1.navigationBar.prefersLargeTitles = true
        
        let vc2 = NotificheOnBoardingVC()
        vc2.doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        let nav2 = UINavigationController(rootViewController: vc2)
        nav2.navigationBar.prefersLargeTitles = true
        
        let vc3 = GenderVC()
        vc3.title = "Sesso"
        let nav3 = ThemedNavigationController(rootViewController: vc3)
        nav3.navigationBar.prefersLargeTitles = true
        
        
        return [nav1, nav3, nav2 ]
    }()

    @objc private func done() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getController(withIdentifier identifier: String, storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    public func getControllerAt(index: Int) -> UIViewController {
        return orderedViewControllers[index]
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
