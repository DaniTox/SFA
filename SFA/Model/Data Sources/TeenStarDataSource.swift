//
//  TeenStarDataSource.swift
//  SFA
//
//  Created by Dani Tox on 15/03/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

struct EntryMemory {
    var sentimento8 : Emozione?
    var sentimento14 : Emozione?
    var sentimento20 : Emozione?
    var ciclo : CicloColor?
    
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
    
    mutating func set(emozione: Emozione, at index: Int) {
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
    var currentEntryMemory : EntryMemory

    init(entry: T) {
        self.entry = entry
        self.currentEntryMemory = EntryMemory()
        super.init()
        
        currentEntryMemory.sentimento8 = entry.sentimentiTable?.sentimentoOre8
        currentEntryMemory.sentimento14 = entry.sentimentiTable?.sentimentoOre14
        currentEntryMemory.sentimento20 = entry.sentimentiTable?.sentimentoOre20
        
        if let parsedEntry = entry as? TeenStarFemmina {
            currentEntryMemory.ciclo = parsedEntry.cicloTable?.cicloColor
        }
    }
    
    func saveTeenStarTable() {
        let realm = try! Realm()
        try? realm.write {
            if let emozione8 = self.currentEntryMemory.sentimento8 {
                entry.sentimentiTable?.sentimentoOre8 = emozione8
            }
            if let emozione14 = self.currentEntryMemory.sentimento14 {
                entry.sentimentiTable?.sentimentoOre14 = emozione14
            }
            if let emozione20 = self.currentEntryMemory.sentimento20 {
                entry.sentimentiTable?.sentimentoOre20 = emozione20
            }
            if let parsedEntry = entry as? TeenStarFemmina, let cicloColor = self.currentEntryMemory.ciclo {
                parsedEntry.cicloTable?.cicloColor = cicloColor
            }
            realm.add(entry, update: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.entry is TeenStarFemmina {
            return TSGIRL_SECTIONS
        } else {
            return TSBOY_SECTIONS
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: BASIC_CELL_ID) as! BoldCell
            cell.selectionStyle = .none
            cell.mainLabel.text = "Data: \(Date().dayOfWeek()) - \(Date().stringValue)"
            return cell
        case 1, 2, 3:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: BASIC_CELL_ID)  as! BoldCell
                cell.selectionStyle = .none
                cell.mainLabel.text = TEENSTAR_INDICES[GET_INDEX(indexPath.section)]
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: EMOZIONE_CELL_ID) as? EmozioneTableViewCell
                
                cell?.newValueSelected = { [weak self] newValue in
                    self?.currentEntryMemory.set(emozione: newValue, at: indexPath.section)
                }
                
                if let emozione = self.currentEntryMemory.getEmozione(from: indexPath.section) {
                    cell?.select(newEmotion: emozione)
                }
                
                return cell!
            default:
                fatalError("row inesistente in una di queste sezioni: [1, 2, 3]")
            }
        case 4:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: BASIC_CELL_ID) as! BoldCell
                cell.selectionStyle = .none
                cell.mainLabel.text = TEENSTAR_INDICES[GET_INDEX(indexPath.section)]
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: CICLO_CELL_ID) as? CicloTableViewCell
                cell?.newValueSelected = { [weak self] newValue in
                    self?.currentEntryMemory.ciclo = newValue
                }
                if let cicloColor = self.currentEntryMemory.ciclo {
                    cell?.select(cicloColor: cicloColor)
                }
                return cell!
            default:
                fatalError("row inesistente in section 4")
            }
        default:
            fatalError("Section inesistente")
        }
    }
    
}

let BASIC_CELL_ID = "cell"
let EMOZIONE_CELL_ID = "emozioneCell"
let CICLO_CELL_ID = "ciclocell"

let BASIC_ROW_HEIGHT : CGFloat = 75
let EMOZIONE_ROW_HEIGHT : CGFloat = 200
let CICLO_ROW_HEIGHT : CGFloat = 500 //350

let TSBOY_SECTIONS = 4
let TSGIRL_SECTIONS = 5

func GET_INDEX(_ index: Int) -> Int { return index - 1 }
