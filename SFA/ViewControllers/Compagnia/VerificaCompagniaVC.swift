//
//  VerificaCompagniaVC.swift
//  SFA
//
//  Created by Daniel Fortesque on 06/01/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class VerificaCompagniaVC: UIViewController, HasCustomView {
    typealias CustomView = VerificaCompagniaView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var model : CompagniaAgent = CompagniaAgent()
    var dataSource : VerificaCompagniaDataSource = VerificaCompagniaDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Verifica Compagnia"
        
        rootView.tableView.estimatedRowHeight = 250
        rootView.tableView.rowHeight = UITableView.automaticDimension
        
        rootView.tableView.register(CompagniaDomandaCell.self, forCellReuseIdentifier: "cell")
        rootView.tableView.delegate = self
        
        dataSource.verifica = model.getLatestVerifica()
        rootView.tableView.dataSource = dataSource
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let realm = try! Realm()
        try? realm.write {
            realm.add(dataSource.verifica, update: true)
        }
    }
    
}

extension VerificaCompagniaVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

