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
    var dataSource : VerificaCompagniaDataSource
    
    init(type: ScuolaType) {
        self.dataSource = VerificaCompagniaDataSource(scuolaType: type)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Il mio percorso formativo"
        
        rootView.tableView.estimatedRowHeight = 250
        rootView.tableView.rowHeight = UITableView.automaticDimension
        
        rootView.tableView.register(CompagniaDomandaCell.self, forCellReuseIdentifier: "cell")
        rootView.tableView.delegate = self
        
        rootView.tableView.dataSource = dataSource
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let realm = try! Realm()
        try? realm.write {
            realm.add(dataSource.verifica, update: .modified)
        }
    }
    
}

extension VerificaCompagniaVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderView()
        let categoria = dataSource.getCategoria(at: section)
        view.mainLabel.text = "\(categoria.name)"
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}

