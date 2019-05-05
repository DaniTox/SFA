//
//  GioProEditorVC.swift
//  MGS
//
//  Created by Dani Tox on 05/05/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GioProEditorVC: UITableViewController {
    
    var taskTable: GioProNet?
    
    init(taskTable: GioProNet? = nil) {
        self.taskTable = taskTable
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
