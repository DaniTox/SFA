//
//  HostViewControleller.swift
//  SFA
//
//  Created by Dani Tox on 24/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class HomeViewController : UIViewController, HasCustomView {
    typealias CustomView = HomeView
    override func loadView() {
        super.loadView()
        self.view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        rootView.regolaButton.addTarget(self, action: #selector(showRegolaController), for: .touchUpInside)
        rootView.noteButton.addTarget(self, action: #selector(showNoteListController), for: .touchUpInside)
        rootView.teenStarButton.addTarget(self, action: #selector(showTeenStarController), for: .touchUpInside)
        rootView.compagniaButton.addTarget(self, action: #selector(showVerificaCompagniaController), for: .touchUpInside)
    }
    
    @objc func showRegolaController() {
        let vc = RegolaCategorieVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // - TODO: Mettere un Button per dismissare lo splitViewController
    @objc private func showNoteListController() {
        let noteListVC = NoteListVC()
        
        if UIDevice.current.deviceType == .pad {
            let nav = ThemedNavigationController(rootViewController: noteListVC)
            nav.navigationBar.prefersLargeTitles = true
            
            let vc2 = UIViewController()
            vc2.view.backgroundColor = Theme.current.controllerBackground
            let nav2 = ThemedNavigationController(rootViewController: vc2)
            nav2.navigationBar.prefersLargeTitles = true
            
            let splitViewController = UISplitViewController()
            splitViewController.delegate = self
            splitViewController.preferredDisplayMode = UISplitViewController.DisplayMode.allVisible
            splitViewController.viewControllers = [nav, nav2]
            present(splitViewController, animated: true)
        } else {
            navigationController?.pushViewController(noteListVC, animated: true)
        }
    }
    
    @objc private func showTeenStarController() {
        let vc = TeenStarListVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func showVerificaCompagniaController() {
        let vc = VerificaCompagniaVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: UISplitViewControllerDelegate {
    func splitViewController(_ svc: UISplitViewController, collapseSecondary vc2: UIViewController, onto vc1: UIViewController) -> Bool {
        return true
    }
}

