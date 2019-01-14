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
        self.title = "Verifica Compagnia"
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        model = CompagniaTestModel(container: container)
        self.verifica = model.getLatestVerifica()
        
        rootView.tableView.register(CompagniaDomandaCell.self, forCellReuseIdentifier: "cell")
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    private func GET_CATEGORIE() -> [CompagniaCategoria]? {
        guard let categorie = self.verifica.categorie as? Set<CompagniaCategoria> else { return nil }
        return Array(categorie)
    }
    
}

extension VerificaCompagniaVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let categorieArray = GET_CATEGORIE() else { return 0 }
        let categoria = categorieArray[section]
        return categoria.domande?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.verifica.categorie?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CompagniaDomandaCell
        if let categorie = GET_CATEGORIE(), let domande = categorie[indexPath.section].domande as? Set<CompagniaDomanda> {
            let domandeArray = Array(domande)
            let domandaObject = domandeArray[indexPath.row]
            cell?.mainLabel.text =  domandaObject.domanda
            
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let categorie = self.verifica.categorie as? Set<CompagniaCategoria> else { return nil }
        let categorieArray = Array(categorie)
        return categorieArray[section].name
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
