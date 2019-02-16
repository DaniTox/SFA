//
//  GenderVC.swift
//  SFA
//
//  Created by Dani Tox on 16/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GenderVC: UIViewController, HasCustomView, OrderedFlowController {
    typealias CustomView = GenderVCView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var orderingCoordinator: OrderedFlowCoordinator?
    var genderSelected : UserGender?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sesso"
        
        NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main) { (notification) in
            self.updateTheme()
        }
        
        rootView.continueButton.addTarget(self, action: #selector(continueOnBoarding), for: .touchUpInside)
        
        rootView.maleBox.boxTouched = { [weak self] in
            genderSaved = .boy
            self?.genderSelected = .boy
            guard let self = self else { return }
            self.select(box: self.rootView.maleBox)
        }
        
        rootView.girlBox.boxTouched = { [weak self] in
            genderSaved = .girl
            self?.genderSelected = .girl
            guard let self = self else { return }
            self.select(box: self.rootView.girlBox)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        orderingCoordinator?.controllerDidActivate(self)
    }
    
    private func updateTheme() {
        rootView.backgroundColor = Theme.current.controllerBackground
    }
    
    @objc private func continueOnBoarding(_ sender: UIButton) {
        if genderSelected == nil {
            showError(withTitle: "Errore", andMessage: "Devi selezionare il sesso prima di continuare")
            return
        }
        orderingCoordinator?.next()
    }
    
    private func select(box: GenderBox) {
        DispatchQueue.main.async { [weak self] in
            box.selectBox()
            if box == self?.rootView.maleBox {
                self?.rootView.girlBox.unselectBox()
            } else {
                self?.rootView.maleBox.unselectBox()
            }
        }
    }

}
