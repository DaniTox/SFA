//
//  SitiDataSource.swift
//  SFA
//
//  Created by Dani Tox on 22/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift
import DZNEmptyDataSet

class SitiDataSource : NSObject, UITableViewDataSource, DZNEmptyDataSetSource {
    
    public var sites : [SitoObject] = [] {
        didSet {
            self.updateHandler?()
        }
    }

    private let agent: SiteLocalizer = SiteLocalizer()
    private var categorie : [SitoCategoria]
    var updateHandler: (() -> Void)?
    
    var errorHandler: ((Error) -> Void)?
    
    var hasAlreadyRequestedSitesWhileEmpty = false
    
    init(categorie: [SitoCategoria]) {
        self.categorie = categorie
        super.init()
        
//        fetchLocalWebsistes()
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
        agent.fetchAllWebsites { (result) in
            switch result {
            case .success(let list):
                self.sites = list.siti.filter { self.categorie.contains($0.type) }
            case .failure(let err):
                self.errorHandler?(err)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boldCell") as! BoldCell
        
        let site = self.sites[indexPath.row]
        var nomeSito = site.nome
        if let scuolaType = site.scuolaType {
            nomeSito.append(" (\(scuolaType.stringValue))")
        }
        cell.mainLabel.text = nomeSito
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Attenzione!"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Attualmente non segui nessuna diocesi o città. Aggiungi la tua diocesi/città dalle Impostazioni per vedere i loro siti web."
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
}
