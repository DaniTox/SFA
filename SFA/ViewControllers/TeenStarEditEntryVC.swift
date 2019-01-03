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

let BASIC_ROW_HEIGHT : CGFloat = 50
let EMOZIONE_ROW_HEIGHT : CGFloat = 200

let TSBOY_SECTIONS = 4
let TSGIRL_SECTIONS = 6

func GET_INDEX(_ index: Int) -> Int { return index - 1 }

class TeenStarEditEntryVC: UIViewController, HasCustomView {
    typealias CustomView = TeenStarEditEntryView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var genderType : UserGender = .girl
    
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
                let str = TEENSTAR_INDICES[GET_INDEX(indexPath.section)]
                cell?.textLabel?.text = "\(str)"
                return cell!
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: EMOZIONE_CELL_ID) as? EmozioneTableViewCell
                return cell!
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (genderType == .boy) ? TSBOY_SECTIONS : TSGIRL_SECTIONS
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return BASIC_ROW_HEIGHT
        } else {
            return EMOZIONE_ROW_HEIGHT
        }
    }
}
