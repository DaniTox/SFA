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
        var selectedTable : GioProNet
        if taskTable == nil {
            selectedTable = GioProNet()
        } else {
            selectedTable = taskTable!
        }
        
        self.dataSource = GioProEditorDataSource(taskTable: selectedTable)
        super.init(style: .grouped)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(dataSource.taskTable.date.dayOfWeek()) - \(dataSource.taskTable.date.stringValue)"
        self.tableView.backgroundColor = Theme.current.tableViewBackground
        self.tableView.separatorStyle = .none
        
        tableView.register(BoldCell.self, forCellReuseIdentifier: "boldCell")
        tableView.register(GioProNetCell.self, forCellReuseIdentifier: "taskCell")
        tableView.register(DatePickerCell.self, forCellReuseIdentifier: "dateCell")
        tableView.delegate = self
        tableView.dataSource = dataSource
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if dataSource.isEntryDateAvailable() {
            dataSource.saveTable()
        }
    }
}

extension GioProEditorVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 { return 150 }
        else { return 80 }
    }
}
