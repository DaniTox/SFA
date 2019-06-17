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
    
    public var sites : [SitoWeb] = []

    private let agent: SiteLocalizer = SiteLocalizer()
    private var categoria : SitoCategoria
    
    init(categoria: SitoCategoria) {
        self.categoria = categoria
        super.init()
    }
    
    private func fetchLocalWebsistes() {
        let scuolaType = User.currentUser().ageScuola
        self.sites = agent.fetchLocalWebsites(type: categoria).filter { $0.scuolaType == scuolaType }
    }
    
    public func getSiteFrom(_ indexPath : IndexPath) -> SitoWeb? {
        return self.sites[indexPath.row]
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
        cell.urlLabel.text = site.url?.absoluteString
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
}
