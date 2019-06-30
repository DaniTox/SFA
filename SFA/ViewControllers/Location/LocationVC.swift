//
//  LocationVC.swift
//  MGS
//
//  Created by Dani Tox on 17/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class LocationVC: UITableViewController {
    
    init() {
        super.init(style: .grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Provincia & città"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.backgroundColor = Theme.current.tableViewBackground
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LocationVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.backgroundColor = Theme.current.backgroundColor
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.textColor = Theme.current.textColor
        
        switch indexPath.row {
        case 0: cell?.textLabel?.text = "Diocesi"
        case 1: cell?.textLabel?.text = "Città"
        default: break
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: navigationController?.pushViewController(DiocesiVC(), animated: true)
        case 1: navigationController?.pushViewController(CityVC(), animated: true)
        default: break
        }
    }
    
}

