//
//  SitiDataSource.swift
//  SFA
//
//  Created by Dani Tox on 22/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class SitiDataSource : NSObject, UITableViewDataSource {
    
    private var sitesCategories : [SitoWebCategoria] = []
    private var model : SitiAgent
    
    public var updateData : (() -> Void)?
    public var type : WebsiteType
    
    public var errorHandler : ((String) -> Void)? {
        didSet {
            guard let handler = errorHandler else { return }
            self.model.errorHandler = handler
        }
    }
    
    init(type: WebsiteType) {
        self.type = type
        self.model = SitiAgent(container: container)
        super.init()
        
        fetchData()
    }
    
    public func fetchData() {
        model.loadSites(type: type, completion: { (newSitesCategories) in
            self.sitesCategories = newSitesCategories
            self.updateData?()
        })
    }
    
    public func getSiteFrom(_ indexPath : IndexPath) -> SitoWeb? {
        let section = indexPath.section
        let row = indexPath.row
        
        let categoria = self.sitesCategories[section]
        if let site = categoria.sitiWeb?[row] as? SitoWeb {
            return site
        }
        return nil
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
            cell.urlLabel.text = site.url?.absoluteString
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sitesCategories[section].name
    }
    
}
