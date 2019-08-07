//
//  GioProEditorDataSource.swift
//  MGS
//
//  Created by Dani Tox on 05/05/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class GioProEditorDataSource: NSObject, UITableViewDataSource {
    
    var tableView: UITableView?
    var gioNetItem: GioProNet
    
    init(item: GioProNet) {
        self.gioNetItem = item
        super.init()
    }
    
    func cellTaskChangedHandler(with time: GioProNetTask.GioProTime, taskType: GioProNetTask.TaskType) {
        let realm = try! Realm()
        
        let task = gioNetItem.getTask(at: time)
        try? realm.write {
            task.taskType = taskType
        }
    }
    
    public func dateChangedAction(date: Date) {
        let realm = try! Realm()
        try? realm.write {
            self.gioNetItem.date = date
        }
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return GioProNetTask.GioProTime.allCases.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return makeHeaderCell(with: "\(self.gioNetItem.date.dayOfWeek()) - \(self.gioNetItem.date.stringValue)", in: tableView)
            case 1:
                return makeHeaderCell(with: "Modifica la data", in: tableView, isDiscolsable: true)
            default: fatalError()
            }
        case 1, 2, 3, 4, 5, 6, 7:
            switch indexPath.row {
            case 0:
                return makeHeaderCell(with: GIOPRONET_INDICES[GET_INDEX(indexPath.section)], in: tableView)
            case 1:
                return makeTaskCell(in: tableView, indexPath: indexPath)
            default: fatalError()
            }
        default: fatalError()
        }
    }
    
    fileprivate func makeTaskCell(in tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! GioProNetCell
        cell.taskSelectedHandler = self.cellTaskChangedHandler
        
        let time = GioProNetTask.GioProTime.allCases[indexPath.section - 1]
        let task = gioNetItem.getTask(at: time)
        
        cell.cellTask = task
        return cell
    }
    
    
    fileprivate func makeDateCell(in tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell") as! DatePickerCell
        cell.datePicker.date = gioNetItem.date
        cell.dateDidChange = { newDate in
            let realm = try! Realm()
            try? realm.write {
                self.gioNetItem.date = newDate
            }
        }
        return cell
    }
    
    func makeHeaderCell(with text: String, in tableView: UITableView, isDiscolsable: Bool = false) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boldCell") as! BoldCell
        cell.selectionStyle = .none
        cell.mainLabel.text = text
        if isDiscolsable {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}
