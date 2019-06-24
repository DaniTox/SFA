//
//  TeenStarDataSource.swift
//  SFA
//
//  Created by Dani Tox on 15/03/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class TSMemory {
    var sentimento8 : Emozione?
    var sentimento14 : Emozione?
    var sentimento20 : Emozione?
    var ciclo : CicloColor?
    var date: Date = Date().startOfDay
    
    func getEmozione(from index: Int) -> Emozione? {
        switch index {
        case 1:
            return sentimento8
        case 2:
            return sentimento14
        case 3:
            return sentimento20
        default:
            return nil
        }
    }
    
    func set(emozione: Emozione, at index: Int) {
        switch index {
        case 1:
            self.sentimento8 = emozione
        case 2:
            self.sentimento14 = emozione
        case 3:
            self.sentimento20 = emozione
        default:
            break
        }
    }
}

class TeenStarDataSource<T: TeenStarDerivative & Object> : NSObject, UITableViewDataSource {
    
    var entry : T
    var currentEntryMemory : TSMemory
    var dateChanged : ((Date) -> Void)?
    var teenStarType : TeenStarType
    
    var tableView: UITableView?
    
    let cicloColors: [CicloColor] = Array(CicloTable.colorDescriptions.keys)

    init(entry: T) {
        self.entry = entry
        self.currentEntryMemory = TSMemory()
        self.teenStarType = (entry is TeenStarFemmina) ? .femmina : .maschio
        super.init()
        
        if let femminaEntry = entry as? TeenStarFemmina {
            currentEntryMemory.ciclo = femminaEntry.cicloTable?.cicloColor
            self.teenStarType = .femmina
        } else if let maschioEntry = entry as? TeenStarMaschio {
            currentEntryMemory.sentimento8 = maschioEntry.sentimentiTable?.sentimentoOre8
            currentEntryMemory.sentimento14 = maschioEntry.sentimentiTable?.sentimentoOre14
            currentEntryMemory.sentimento20 = maschioEntry.sentimentiTable?.sentimentoOre20
            self.teenStarType = .maschio
        } else {
            fatalError()
        }
        
        currentEntryMemory.date = entry.date.startOfDay
    }
    
    private func isDateAvailable(_ date: Date) -> Bool {
        let realm = try! Realm()
        let calendar = Calendar.current
        
        let dateFrom = calendar.startOfDay(for: date)
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)!
        
        let fromPredicate = NSPredicate(format: "date > %@", dateFrom as NSDate)
        let toPredicate = NSPredicate(format: "date < %@", dateTo as NSDate)
        let fullPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        
        let objects = realm.objects(T.self).filter(fullPredicate)
        return objects.count == 0
    }
    
    func dateDidChangeAction(date: Date) {
        self.currentEntryMemory.date = date
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
        self.dateChanged?(date)
    }
    
    func isEntryDateAvailable() -> Bool {
        return self.isDateAvailable(currentEntryMemory.date)
    }
    
    func saveTeenStarTable() {
        let realm = try! Realm()
        try? realm.write {
            entry.date = self.currentEntryMemory.date
            
            if let femminaEntry = entry as? TeenStarFemmina, let cicloColor = self.currentEntryMemory.ciclo {
                femminaEntry.cicloTable?.cicloColor = cicloColor
            } else if let maschioEntry = entry as? TeenStarMaschio {
                if let emozione8 = self.currentEntryMemory.sentimento8 {
                    maschioEntry.sentimentiTable?.sentimentoOre8 = emozione8
                }
                if let emozione14 = self.currentEntryMemory.sentimento14 {
                    maschioEntry.sentimentiTable?.sentimentoOre14 = emozione14
                }
                if let emozione20 = self.currentEntryMemory.sentimento20 {
                    maschioEntry.sentimentiTable?.sentimentoOre20 = emozione20
                }
            }
            
            realm.add(entry, update: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (teenStarType == .femmina) ? femaleRowsModel(section: section) : maleRowsModel(section: section)
    }
    
    func femaleRowsModel(section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return self.cicloColors.count
        default: fatalError()
        }
    }
    
    func maleRowsModel(section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.entry is TeenStarFemmina {
            return TSGIRL_SECTIONS
        } else {
            return TSBOY_SECTIONS
        }
    }
    
    fileprivate func makeEmozioneCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EMOZIONE_CELL_ID) as? EmozioneTableViewCell
        
        cell?.newValueSelected = { [weak self] newValue in
            self?.currentEntryMemory.set(emozione: newValue, at: indexPath.section)
        }
        
        if let emozione = self.currentEntryMemory.getEmozione(from: indexPath.section) {
            cell?.select(newEmotion: emozione)
        }
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.teenStarType == .femmina {
            return femaleModel(tableView: tableView, indexPath: indexPath)
        } else {
            return maleModel(tableView: tableView, indexPath: indexPath)
        }
    }
    
    //called from the tableViewDelegate
    func cellWasSelected(controller: UIViewController, tableView: UITableView, indexPath: IndexPath) {
        if self.teenStarType == .femmina && indexPath.section == 1 {
            let color = cicloColors[indexPath.row]
            self.currentEntryMemory.ciclo = color
            tableView.reloadData()
        } else if indexPath.section == 0 && indexPath.row == 1 {
            let vc = DatePickerVC(maxDate: Date(), dateChangedHandler: self.dateDidChangeAction)
            vc.currentDate = currentEntryMemory.date
            controller.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func maleModel(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return makeHeaderCell(with: "\(currentEntryMemory.date.dayOfWeek()) - \(currentEntryMemory.date.stringValue)", in: tableView)
            case 1:
                return makeHeaderCell(with: "Modifica la data", in: tableView, isDisclosable: true)
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
    
    func femaleModel(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return makeHeaderCell(with: "\(currentEntryMemory.date.dayOfWeek()) - \(currentEntryMemory.date.stringValue)", in: tableView)
            case 1:
                return makeHeaderCell(with: "Modifica la data", in: tableView, isDisclosable: true)
            default: fatalError()
            }
        case 1:
            return makeCicloCell(tableView: tableView, indexPath: indexPath)
        default: fatalError()
        }
    }
    
    fileprivate func makeCicloCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CICLO_CELL_ID) as! TeenStarFemminaCell
        let color = self.cicloColors[indexPath.row]
        cell.set(color: color)
        
        if color == self.currentEntryMemory.ciclo {
            cell.containerView.backgroundColor = .green
        } else {
            cell.containerView.backgroundColor = Theme.current.backgroundColor
        }
        
        return cell
    }
    
    fileprivate func makeDateCell(in tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DATE_CELL_ID) as! DatePickerCell
        cell.datePicker.date = entry.date
        cell.dateDidChange = { newDate in
            self.currentEntryMemory.date = newDate
            self.dateChanged?(newDate)
        }
        return cell
    }
    
    func makeHeaderCell(with text: String, in tableView: UITableView, isDisclosable: Bool = false) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BASIC_CELL_ID) as! BoldCell
        cell.selectionStyle = .none
        cell.mainLabel.text = text
        
        if isDisclosable {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}

let BASIC_CELL_ID = "cell"
let DATE_CELL_ID = "dateCell"
let EMOZIONE_CELL_ID = "emozioneCell"
let CICLO_CELL_ID = "ciclocell"

let BASIC_ROW_HEIGHT : CGFloat = 75
let EMOZIONE_ROW_HEIGHT : CGFloat = 200
let CICLO_ROW_HEIGHT : CGFloat = 500 //350

let TSBOY_SECTIONS = 4
let TSGIRL_SECTIONS = 2

func GET_INDEX(_ index: Int) -> Int { return index - 1 }
