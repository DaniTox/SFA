//
//  TeenStarEditEntryVC.swift
//  SFA
//
//  Created by Dani Tox on 03/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class TeenStarEditEntryVC<T : TeenStarDerivative & Object>: UIViewController, HasCustomView, UITableViewDelegate {
    typealias CustomView = TeenStarEditEntryView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }

    var dataSource : TeenStarDataSource<T>
    
    init(table : T? = nil) {
        var selectedTable : T
        if table == nil {
            selectedTable = T()
        } else {
            selectedTable = table!
        }
        
        self.dataSource = TeenStarDataSource<T>(entry: selectedTable)
        super.init(nibName: nil, bundle: nil)
        
        dataSource.dateChanged = { [weak self] newDate in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.title = "\(newDate.dayOfWeek()) - \(newDate.stringValue)"
            }
            
            if !self.dataSource.isEntryDateAvailable() {
                self.showError(withTitle: "Errore", andMessage: "Questa data è già stata salvata.")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        self.title = "\(dataSource.entry.date.dayOfWeek()) - \(dataSource.entry.date.stringValue)"
        
        NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main) { (notification) in
            self.updateTheme()
        }
        
        dataSource.tableView = self.rootView.tableView
        
        rootView.tableView.register(BoldCell.self, forCellReuseIdentifier: BASIC_CELL_ID)
        rootView.tableView.register(EmozioneTableViewCell.self, forCellReuseIdentifier: EMOZIONE_CELL_ID)
        rootView.tableView.register(TeenStarFemminaCell.self, forCellReuseIdentifier: CICLO_CELL_ID)
        rootView.tableView.register(DatePickerCell.self, forCellReuseIdentifier: DATE_CELL_ID)
        
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = dataSource
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if dataSource.isEntryDateAvailable() {
            dataSource.saveTeenStarTable()
        }
    }
    
    private func updateTheme() {
        self.rootView.tableView.backgroundColor = Theme.current.tableViewBackground
        self.rootView.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource.cellWasSelected(controller: self, tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataSource.teenStarType == .femmina {
            return femaleHeight(indexPath: indexPath)
        } else {
            return maleHeight(indexPath: indexPath)
        }
    }
    
    func maleHeight(indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { return BASIC_ROW_HEIGHT }
        if indexPath.row == 0 { return BASIC_ROW_HEIGHT }
        else { return EMOZIONE_ROW_HEIGHT }
    }
    
    func femaleHeight(indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { return BASIC_ROW_HEIGHT }
        else { return 180 }
    }
    
}
