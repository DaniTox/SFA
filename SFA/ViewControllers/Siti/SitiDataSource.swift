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
    
    public var sites : [SitoObject] = [] {
        didSet {
            self.updateHandler?()
        }
    }

    private let agent: SiteLocalizer = SiteLocalizer()
    private var categorie : [SitoCategoria]
    var updateHandler: (() -> Void)?
    
    init(categorie: [SitoCategoria]) {
        self.categorie = categorie
        super.init()
        
        fetchLocalWebsistes()
    }
    
    public func fetchLocalWebsistes() {
        self.sites.removeAll(keepingCapacity: true)
        for categoria in self.categorie {
            self.sites.append(contentsOf: agent.fetchLocalWebsites(type: categoria))
        }
    }
    
    public func getSiteFrom(_ indexPath : IndexPath) -> SitoObject? {
        return self.sites[indexPath.row]
    }
    
    public func updateFromServer() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sitoCell") as! SitoCell
        
        let site = self.sites[indexPath.row]
        var nomeSito = site.nome
        if let scuolaType = site.scuolaType {
            nomeSito.append(" (\(scuolaType.stringValue))")
        }
        cell.nomeSitoLabel.text = nomeSito
        cell.urlLabel.text = site.urlString
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
}
