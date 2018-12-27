//
//  NoteListVC.swift
//  SFA
//
//  Created by Dani Tox on 27/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class NoteListVC: UIViewController, HasCustomView {
    typealias CustomView = NoteListView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
