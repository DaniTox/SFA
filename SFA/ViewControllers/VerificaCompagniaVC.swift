//
//  VerificaCompagniaVC.swift
//  SFA
//
//  Created by Daniel Fortesque on 06/01/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class VerificaCompagniaVC: UIViewController, HasCustomView {
    typealias CustomView = VerificaCompagniaView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var verifica : CompagniaTest!
    var model : CompagniaTestModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        model = CompagniaTestModel(container: container)
        self.verifica = model.getLatestVerifica()
        
        rootView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
}

extension VerificaCompagniaVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let categorie = self.verifica.categorie as? Set<CompagniaCategoria> else { return 0 }
        let categorieArray = Array(categorie)
        let categoria = categorieArray[section]
        return categoria.domande?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.verifica.categorie?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
