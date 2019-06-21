//
//  GioProEditorVC.swift
//  MGS
//
//  Created by Dani Tox on 05/05/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class GioProEditorVC: UITableViewController {

    var dataSource : GioProEditorDataSource
    var gioItem: GioProNet
    
    init(taskTable: GioProNet? = nil) {
        if taskTable == nil {
            gioItem = GioProNet()
        } else {
            gioItem = taskTable!
        }
        
        self.dataSource = GioProEditorDataSource(item: gioItem)
        super.init(style: .grouped)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(dataSource.gioNetItem.date.dayOfWeek()) - \(dataSource.gioNetItem.date.stringValue)"
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
        let realm = try! Realm()
            
        if !self.gioItem.isConsideredEmpty && GioProNetAgent.isDateAvailable(for: self.gioItem) {
            try? realm.write {
                realm.add(gioItem, update: true)
            }
        }
    }
}

extension GioProEditorVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 { return 200 }
        else { return 80 }
    }
}
