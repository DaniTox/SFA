//
//  TeenStarEditEntryVC.swift
//  SFA
//
//  Created by Dani Tox on 03/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

let BASIC_CELL_ID = "cell"
let EMOZIONE_CELL_ID = "emozioneCell"

class TeenStarEditEntryVC: UIViewController, HasCustomView {
    typealias CustomView = TeenStarEditEntryView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var genderType : UserGender = .boy
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        rootView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: BASIC_CELL_ID)
        rootView.tableView.register(EmozioneTableViewCell.self, forCellReuseIdentifier: EMOZIONE_CELL_ID)
        
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
}
extension TeenStarEditEntryVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BASIC_CELL_ID)
            cell?.textLabel?.text = "Data: \(Date().dayOfWeek()) - \(Date().stringValue)"
            return cell!
        } else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: BASIC_CELL_ID)
                let index = indexPath.section - 1
                let str = TEENSTAR_INDICES[index]
                cell?.textLabel?.text = "\(str)"
                return cell!
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: EMOZIONE_CELL_ID) as? EmozioneTableViewCell
                return cell!
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (genderType == .boy) ? 4 : 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        } else {
            return 200
        }
    }
}
