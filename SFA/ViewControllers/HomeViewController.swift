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
        let nav = UINavigationController(rootViewController: noteListVC)
        
        //let noteViewerVC = NoteVC(nota: nil)
        //let nav2 = UINavigationController(rootViewController: noteViewerVC)
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .white
        let nav2 = UINavigationController(rootViewController: vc2)
        
        let splitViewController = UISplitViewController()
        splitViewController.delegate = self
        splitViewController.preferredDisplayMode = UISplitViewController.DisplayMode.allVisible
        splitViewController.viewControllers = [nav, nav2]
        present(splitViewController, animated: true)
//        navigationController?.pushViewController(splitViewController, animated: true)
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

class HomeView : UIView {
    
    lazy var regolaButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Regola di Vita", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.8
        button.backgroundColor = .green
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var noteButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Diario personale", for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.8
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var teenStarButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("TeenSTAR", for: .normal)
        button.backgroundColor = .purple
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.8
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var compagniaButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Compagnia", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.8
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        stackView.addArrangedSubview(regolaButton)
        stackView.addArrangedSubview(noteButton)
        stackView.addArrangedSubview(teenStarButton)
        stackView.addArrangedSubview(compagniaButton)
        addSubview(stackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.70).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

