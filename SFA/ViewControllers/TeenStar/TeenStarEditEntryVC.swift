//
//  TeenStarEditEntryVC.swift
//  SFA
//
//  Created by Dani Tox on 03/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

struct EntryMemory {
    var sentimento8 : Emozione?
    var sentimento14 : Emozione?
    var sentimento20 : Emozione?
    var ciclo : CicloColor?
}

class TeenStarEditEntryVC<T : TeenStarDerivative & Object>: UIViewController, HasCustomView {
    typealias CustomView = TeenStarEditEntryView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }

    var currentEntryMemory : EntryMemory!
    var entry : T
    
    init(table : T) {
        self.entry = table
        super.init(nibName: nil, bundle: nil)
        
        currentEntryMemory.sentimento8 = entry.sentimentiTable?.sentimentoOre8
        currentEntryMemory.sentimento14 = entry.sentimentiTable?.sentimentoOre14
        currentEntryMemory.sentimento20 = entry.sentimentiTable?.sentimentoOre20
        
        if let parsedEntry = entry as? TeenStarFemmina {
            currentEntryMemory.ciclo = parsedEntry.cicloTable?.cicloColor
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var genderType : UserGender? {
        didSet {
            guard let _ = self.genderType else { return }
            DispatchQueue.main.async { [weak self] in
                self?.rootView.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        self.title = "\(entry.date.dayOfWeek()) - \(entry.date.stringValue)"
        
        NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main) { (notification) in
            self.updateTheme()
        }
        
        rootView.tableView.register(BoldCell.self, forCellReuseIdentifier: BASIC_CELL_ID)
        rootView.tableView.register(EmozioneTableViewCell.self, forCellReuseIdentifier: EMOZIONE_CELL_ID)
        rootView.tableView.register(CicloTableViewCell.self, forCellReuseIdentifier: CICLO_CELL_ID)
        
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveTeenStarEntry()
    }
    
    private func updateTheme() {
        self.rootView.tableView.backgroundColor = Theme.current.tableViewBackground
        self.rootView.tableView.reloadData()
    }
    
    private func saveTeenStarEntry() {
        
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
        
        let realm = try! Realm()
        try? realm.write {
            realm.add(entry, update: true)
        }
    }

}
extension TeenStarEditEntryVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : 2
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
                cell?.newValueSelected = { [weak self] (newValue) in
                    self?.currentEntryMemory[indexPath.section] = newValue.rawValue
                }
                if let valueInMemory = self.currentEntryMemory[indexPath.section], let emotion = Emozione(rawValue: valueInMemory) {
                    cell?.select(newEmotion: emotion)
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
                    self?.currentEntryMemory[indexPath.section] = newValue.rawValue
                }
                if let valueInMemory = self.currentEntryMemory[indexPath.section], let cicloColor = CicloColor(rawValue: valueInMemory) {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (genderType == .boy) ? TSBOY_SECTIONS : TSGIRL_SECTIONS
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0, 1, 2, 3:
            if indexPath.row == 0 { return BASIC_ROW_HEIGHT }
            else { return EMOZIONE_ROW_HEIGHT }
        case 4:
            if indexPath.row == 0 { return BASIC_ROW_HEIGHT }
            else { return CICLO_ROW_HEIGHT }
        default:
            return 0
        }
    }
}
