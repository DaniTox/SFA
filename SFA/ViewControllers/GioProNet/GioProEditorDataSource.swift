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
    
    var taskTable: GioProNet
    var objectMemory: GioProMemory
    
    init(taskTable: GioProNet) {
        self.taskTable = taskTable
        self.objectMemory = GioProMemory()
        super.init()
        
        objectMemory.task2 = taskTable.taskTable?.taskAt2
        objectMemory.task7 = taskTable.taskTable?.taskAt7
        objectMemory.task11 = taskTable.taskTable?.taskAt11
        objectMemory.task14 = taskTable.taskTable?.taskAt14
        objectMemory.task17 = taskTable.taskTable?.taskAt17
        objectMemory.task20 = taskTable.taskTable?.taskAt20
        objectMemory.task23 = taskTable.taskTable?.taskAt23
        
        objectMemory.date = taskTable.date
        
    }

    func saveTable() {
        let realm = try! Realm()
        try? realm.write {
            taskTable.date = self.objectMemory.date
            
            if let task2 = objectMemory.task2 {
                taskTable.taskTable?.taskAt2 = task2
            }
            if let task7 = objectMemory.task2 {
                taskTable.taskTable?.taskAt2 = task7
            }
            if let task11 = objectMemory.task2 {
                taskTable.taskTable?.taskAt2 = task11
            }
            if let task14 = objectMemory.task2 {
                taskTable.taskTable?.taskAt2 = task14
            }
            if let task17 = objectMemory.task2 {
                taskTable.taskTable?.taskAt2 = task17
            }
            if let task20 = objectMemory.task2 {
                taskTable.taskTable?.taskAt2 = task20
            }
            if let task23 = objectMemory.task2 {
                taskTable.taskTable?.taskAt2 = task23
            }
            
            realm.add(taskTable, update: true)
        }
    }
    
    func isEntryDateAvailable() -> Bool {
        return self.isDateAvailable(objectMemory.date)
    }
    
    private func isDateAvailable(_ date: Date) -> Bool {
        let realm = try! Realm()
        let calendar = Calendar.current
        
        let dateFrom = calendar.startOfDay(for: date)
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)!
        
        let fromPredicate = NSPredicate(format: "date > %@", dateFrom as NSDate)
        let toPredicate = NSPredicate(format: "date < %@", dateTo as NSDate)
        let fullPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        
        let objects = realm.objects(GioProNet.self).filter(fullPredicate)
        return objects.count == 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return makeHeaderCell(with: "Seleziona la data", in: tableView)
            case 1:
                return makeDateCell(in: tableView)
            default: fatalError()
            }
        case 1, 2, 3:
            switch indexPath.row {
            case 0:
                return makeHeaderCell(with: TEENSTAR_INDICES[GET_INDEX(indexPath.section)], in: tableView)
            case 1:
                return makeEmozioneCell(tableView, indexPath)
            default: fatalError()
            }
        default: fatalError()
        }
    }
    
    fileprivate func makeDateCell(in tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DATE_CELL_ID) as! DatePickerCell
        cell.datePicker.date = taskTable.date
        cell.dateDidChange = { newDate in
            self.objectMemory.date = newDate
//            self.dateChanged?(newDate)
        }
        return cell
    }
    
    func makeHeaderCell(with text: String, in tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BASIC_CELL_ID) as! BoldCell
        cell.selectionStyle = .none
        cell.mainLabel.text = text
        return cell
    }
}
