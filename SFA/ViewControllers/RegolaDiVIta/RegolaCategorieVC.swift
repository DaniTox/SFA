//
//  RegolaCategorieVC.swift
//  SFA
//
//  Created by Dani Tox on 25/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit
import CoreData

class RegolaCategorieVC: UIViewController, HasCustomView {
    typealias CustomView = RegoleCategorieView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var persistentContainer : NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    var tableView : UITableView { return rootView.tableView }
    var regola: Regola?
    let regolaFetcherModel = RegolaFetcherModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regolaFetcherModel.persistentContainer = persistentContainer
        
        title = "Categorie"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        rootView.refreshControl.addTarget(self, action: #selector(tablePulled), for: .valueChanged)
        
        self.regola = regolaFetcherModel.getRegola()
    }
    
    @objc private func tablePulled() {
        tableView.reloadData()
    }

}

extension RegolaCategorieVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regola?.categorie?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//        cell.textLabel?.text = self.regola?.categorie?[indexPath.row]
//        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = DomandeVC()
//        guard let categories = self.regola?.categorie else { return }
//        let selectedCategory = categories.[indexPath.row]
//
//        guard let selectedDomande = self.regola?.domandeForCategory(selectedCategory) else { return }
//        vc.domande = selectedDomande
//        vc.title = selectedCategory
//        tableView.deselectRow(at: indexPath, animated: true)
//        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
