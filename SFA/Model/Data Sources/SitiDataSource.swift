//
//  SitiDataSource.swift
//  SFA
//
//  Created by Dani Tox on 22/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import CoreData

class SitiDataSource : NSObject, UITableViewDataSource {
    
    private var persistentContainer : NSPersistentContainer
    private var sitesCategories : [SitoWebCategoria] = []
    private var model : SitiAgent
    public var updateData : (() -> Void)?
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.model = SitiAgent(container: container)
//        self.sitesCategories = model.fetchLocalWebsites()
        super.init()
        model.loadSites(completion: { (newSitesCategories) in
            self.sitesCategories = newSitesCategories
            self.updateData?()
        })
        
//        model.loadSites { [weak self] (newSites) in
//            self?.sitesCategories = newSites
//            self?.updateData?()
//        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sitesCategories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sitesCategories[section].sitiWeb?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sitoCell") as! SitoCell
        if let site = self.sitesCategories[indexPath.section].sitiWeb?[indexPath.row] as? SitoWeb {
            cell.nomeSitoLabel.text = site.nome
            cell.urlLabel.text = site.url?.path
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sitesCategories[section].name
    }
    
}
