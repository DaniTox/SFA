//
//  RiassuntoVC.swift
//  MGS
//
//  Created by Dani Tox on 08/04/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class RiassuntoVC : UITableViewController {

    let dataSource = RiassuntoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "La tua Regola"
        self.view.backgroundColor = Theme.current.tableViewBackground
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(regolaViewWasTapped))
        self.navigationItem.setRightBarButton(rightButton, animated: true)
        
        self.tableView.separatorStyle = .none   
        self.tableView.dataSource = dataSource
        self.tableView.register(BoldCell.self, forCellReuseIdentifier: "cell")
        self.tableView.reloadData()
    }
    
    @objc func regolaViewWasTapped() {
        let vc = RegolaCategorieVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderView()
        let domanda = dataSource.getDomanda(at: section)
        view.mainLabel.text = "\(domanda?.categoria.first?.nome ?? "Errore titolo...")"
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
