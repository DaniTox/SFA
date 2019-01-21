//
//  DomandeView.swift
//  SFA
//
//  Created by Dani Tox on 25/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class DomandeView: UIView {
    
    lazy var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.tableFooterView = UIView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = Theme.current.tableViewBackground
        return table
    }()

    lazy var refreshControl : UIRefreshControl = UIRefreshControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.refreshControl = refreshControl
        addSubview(tableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
