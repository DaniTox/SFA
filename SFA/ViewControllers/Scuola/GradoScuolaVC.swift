//
//  GradoScuolaVC.swift
//  SFA
//
//  Created by Dani Tox on 17/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

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
        rootView.biennioButton.addTarget(self, action: #selector(biennioTouched), for: .touchUpInside)
        rootView.triennioButton.addTarget(self, action: #selector(triennioTouched), for: .touchUpInside)
        
        checkButton()
    }

    func checkButton() {
        switch User.currentUser().ageScuola {
        case .medie:
            rootView.medieButton.backgroundColor = UIColor.green
        case .biennio:
            rootView.biennioButton.backgroundColor = UIColor.green
        case .triennio:
            rootView.triennioButton.backgroundColor = UIColor.green
        }
    }
    
    @objc private func medieTouched() {
        let realm = try! Realm()
        try? realm.write {
            User.currentUser().ageScuola = .medie
        }
        workFinished()
    }
    
    @objc private func biennioTouched() {
        let realm = try! Realm()
        try? realm.write {
            User.currentUser().ageScuola = .biennio
        }
        workFinished()
    }
    
    @objc private func triennioTouched() {
        let realm = try! Realm()
        try? realm.write {
            User.currentUser().ageScuola = .triennio
        }
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
