//
//  NoteVC.swift
//  SFA
//
//  Created by Dani Tox on 11/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class NoteVC: UIViewController, HasCustomView {
    typealias CustomView = NoteView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
