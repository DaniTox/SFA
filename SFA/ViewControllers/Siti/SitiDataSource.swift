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
    private var model : SitiAgent
    
    public var databaseUpdated : (() -> Void)?
    public var networkSitesUpdated : (() -> Void)?
    
    private var type : WebsiteType
    
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
    }
    
    public func fetchData(completion: (() -> Void)? = nil) {
        self.fetchLocalWebsistes()
        if self.sites.count == 0 {
            model.fetchFromNetwork(type: self.type) { [weak self] in
                DispatchQueue.main.async {
                    self?.fetchLocalWebsistes()
                    completion?()
                }
            }
        } else {
            completion?()
        }
    }
    
    private func fetchLocalWebsistes() {
        self.sites =  model.fetchLocalWebsites(type: type)
    }
    
    public func fetchSitesFromNetwork(completion: (() -> Void)? = nil) {
        model.fetchFromNetwork(type: self.type) {
            DispatchQueue.main.async {
                self.fetchLocalWebsistes()
                completion?()
            }
        }
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
        cell.nomeSitoLabel.text = site.nome
        cell.urlLabel.text = site.url?.absoluteString
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
}
