//
//  LicenseVC.swift
//  MGS
//
//  Created by Dani Tox on 23/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class LicenseVC: UITableViewController {

    struct LicenseItem {
        var image: UIImage
        var title: String
    }
    
    let items: [LicenseItem] = [
        .init(image: #imageLiteral(resourceName: "diary"), title: "Diary by SBTS"),
        .init(image: #imageLiteral(resourceName: "airplane"), title: "Airplane by Shocho"),
        .init(image: #imageLiteral(resourceName: "search"), title: "Magnifying Glass by Phil Goodwin"),
        .init(image: #imageLiteral(resourceName: "weightscale"), title: "Weight Scale by Marco Livolsi"),
        .init(image: #imageLiteral(resourceName: "star"), title: "Star by Mochamad Frans Kurnia"),
        .init(image: #imageLiteral(resourceName: "calendar"), title: "Calendar by Alice Design"),
        .init(image: #imageLiteral(resourceName: "home"), title: "Home by Taqiyyah"),
        .init(image: #imageLiteral(resourceName: "school_bag"), title: "School Bag by Nociconist"),
        .init(image: #imageLiteral(resourceName: "social"), title: "Social by Leo"),
        .init(image: #imageLiteral(resourceName: "verifiche"), title: "Homework by Made"),
        .init(image: #imageLiteral(resourceName: "settings"), title: "Settings by Royyan Wijaya"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.title = "Licenze"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.tableView.backgroundColor = Theme.current.tableViewBackground
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.backgroundColor = Theme.current.backgroundColor
        cell.textLabel?.textColor = Theme.current.textColor
        cell.detailTextLabel?.textColor = Theme.current.cellSubtitleColor
        
        let item = items[indexPath.row]
        cell.imageView?.image = item.image
        cell.imageView?.tintColor = Theme.current.textColor
        cell.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        cell.textLabel?.text = "\(item.title) - (thenounproject.com)"
        cell.detailTextLabel?.text = "Creative Commons License - creativecommons.org/licenses/by/3.0/"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return "Icone" }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 && shouldDisplayDeveloperName { return "App sviluppata da Daniel Bazzani" }
        return ""
    }
    
}
