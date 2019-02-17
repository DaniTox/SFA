//
//  SitiListView.swift
//  SFA
//
//  Created by Dani Tox on 22/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class SitiListView : UIView {
    
    lazy var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: UITableView.Style.grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView()
        
        table.backgroundColor = Theme.current.tableViewBackground
        table.separatorStyle = .none
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        table.tableHeaderView = UIView(frame: frame)
        
        return table
    }()
    
    public var refreshControl : UIRefreshControl = UIRefreshControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.refreshControl = refreshControl
        addSubview(tableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

