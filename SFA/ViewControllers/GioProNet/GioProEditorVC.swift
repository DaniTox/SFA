//
//  GioProEditorVC.swift
//  MGS
//
//  Created by Dani Tox on 05/05/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GioProEditorVC: UITableViewController {
    
    
    
    var dataSource : GioProEditorDataSource
    
    init(taskTable: GioProNet? = nil) {
        self.dataSource = GioProEditorDataSource(taskTable: taskTable)
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(dataSource.taskTable.date.dayOfWeek()) - \(dataSource.taskTable.date.stringValue)"
        
        tableView.register(BoldCell.self, forCellReuseIdentifier: "boldCell")
        tableView.register(GioProNetCell.self, forCellReuseIdentifier: "gioproCell")
        tableView.delegate = self
        tableView.dataSource = dataSource
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if dataSource.isEntryDateAvailable() {
            dataSource.saveTeenStarTable()
        }
    }
}

extension GioProEditorVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
