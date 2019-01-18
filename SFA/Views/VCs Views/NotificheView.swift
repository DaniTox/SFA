//
//  NotificheView.swift
//  SFA
//
//  Created by Dani Tox on 18/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class NotificheView: UIView {

    lazy var tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView()
        return table
    }()
    
    lazy var  : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Regola di Vita", for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
