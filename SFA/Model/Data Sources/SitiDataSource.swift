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
    
    private var sites : [SitoWeb] = []
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
        self.model = SitiAgent()
        super.init()
        
        fetchData()
    }
    
    public func fetchData() {
        model.loadSites(type: type, completion: { (newSites) in
            self.sites = newSites
            self.updateData?()
        })
    }
    
    public func getSiteFrom(_ indexPath : IndexPath) -> SitoWeb? {
        let section = indexPath.section
        let row = indexPath.row
        
        let categoria = self.sitesCategories[section]
        return categoria.siti[row]
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sitesCategories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sitesCategories[section].siti.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sitoCell") as! SitoCell
        
        let site = self.sitesCategories[indexPath.section].siti[indexPath.row]
        cell.nomeSitoLabel.text = site.nome
        cell.urlLabel.text = site.url.absoluteString
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sitesCategories[section].nome
    }
    
}
