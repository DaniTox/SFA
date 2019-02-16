//
//  GenderVC.swift
//  SFA
//
//  Created by Dani Tox on 16/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GenderVC: UIViewController, HasCustomView {
    typealias CustomView = GenderVCView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.maleBox.boxTouched = { [weak self] in
            genderSaved = .boy
            guard let self = self else { return }
            self.select(box: self.rootView.maleBox)
        }
        
        rootView.girlBox.boxTouched = { [weak self] in
            genderSaved = .girl
            guard let self = self else { return }
            self.select(box: self.rootView.girlBox)
        }
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
