//
//  EditRispostaVC.swift
//  SFA
//
//  Created by Dani Tox on 26/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift


class EditRispostaVC : UIViewController, HasCustomView {
    typealias CustomView = EditRispostaView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var domandaObject : RegolaDomanda
    
    init(domanda: RegolaDomanda) {
        self.domandaObject = domanda
        super.init(nibName: nil, bundle: nil)
        
        rootView.domandaLabel.text = domandaObject.domanda
        rootView.textView.text = domandaObject.risposta
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Risposta"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveRisposta()
    }
    
    private func saveRisposta() {
        let newRisposta = rootView.textView.text
        
        let realm = try! Realm()
        try? realm.write {
            domandaObject.risposta = newRisposta
        }
    }
}
