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
    
    init(table : T) {
        self.dataSource = TeenStarDataSource(entry: table)
        super.init(nibName: nil, bundle: nil)
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
        
        rootView.tableView.register(BoldCell.self, forCellReuseIdentifier: BASIC_CELL_ID)
        rootView.tableView.register(EmozioneTableViewCell.self, forCellReuseIdentifier: EMOZIONE_CELL_ID)
        rootView.tableView.register(CicloTableViewCell.self, forCellReuseIdentifier: CICLO_CELL_ID)
        
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = dataSource
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
        dataSource.saveTeenStarTable()
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
