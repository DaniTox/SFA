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
        
        checkButton()
    }

    func checkButton() {
        self.rootView.updateView(for: User.currentUser().ageScuola)
    }
    
    @objc private func medieTouched() {
        let realm = try! Realm()
        try? realm.write {
            User.currentUser().ageScuola = .medie
        }
        workFinished()
        rootView.updateView(for: .medie)
    }
    
    @objc private func biennioTouched() {
        let realm = try! Realm()
        try? realm.write {
            User.currentUser().ageScuola = .biennio
        }
        workFinished()
        rootView.updateView(for: .biennio)
    }
    
    @objc private func triennioTouched() {
        let realm = try! Realm()
        try? realm.write {
            User.currentUser().ageScuola = .triennio
        }
        workFinished()
        rootView.updateView(for: .triennio)
    }
    
    public func workFinished() {
        orderingCoordinator?.next()
        finishAction?()
    }
    
    private func updateTheme() {
        rootView.backgroundColor = Theme.current.tableViewBackground
    }
    
    
}
