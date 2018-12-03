//
//  EditRispostaVC.swift
//  SFA
//
//  Created by Dani Tox on 26/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class EditRispostaVC : UIViewController, HasCustomView {
    typealias CustomView = EditRispostaView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var domandaObject : Domanda! {
        didSet {
            guard let domanda = domandaObject else { fatalError("domandaObject == nil")}
            rootView.domandaLabel.text = domanda.domanda
            rootView.textView.text = domanda.risposta
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Risposta"
    }
}
