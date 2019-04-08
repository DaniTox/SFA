//
//  RiassuntoVC.swift
//  MGS
//
//  Created by Dani Tox on 08/04/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class RiassuntoVC : UITableViewController {
    
    var regola: RegolaVita?
    let categoriesIndexes : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "La tua Regola"
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(regolaViewWasTapped))
        self.navigationItem.setRightBarButton(rightButton, animated: true)
        
        self.regola = RegolaFetcherModel.shared.getRegola()
        
        self.tableView.register(BoldCell.self, forCellReuseIdentifier: "cell")
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
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BoldCell
        
        return cell
    }
    
}
