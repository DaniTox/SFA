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
    
    var model : CompagniaTestModel!
    var dataSource : VerificaCompagniaDataSource = VerificaCompagniaDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Verifica Compagnia"
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        model = CompagniaTestModel(container: container)
        
        rootView.tableView.register(CompagniaDomandaCell.self, forCellReuseIdentifier: "cell")
        rootView.tableView.delegate = self
        
        dataSource.verifica = model.getLatestVerifica()
        rootView.tableView.dataSource = dataSource
        
        rootView.tableView.estimatedRowHeight = 250
        rootView.tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let _ = try? dataSource.verifica.managedObjectContext?.save() else {
            fatalError("Errore nel salvataggio")
        }
    }
    
}

extension VerificaCompagniaVC : UITableViewDelegate {
    
}

//extension VerificaCompagniaVC : UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let categorieArray = GET_CATEGORIE() else { return 0 }
//        let categoria = categorieArray[section]
//        return categoria.domande?.count ?? 0
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.verifica.categorie?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CompagniaDomandaCell
//        if
//            let categorie = GET_CATEGORIE(),
//            let domande = categorie[indexPath.section].domande as? Set<CompagniaDomanda>
//        {
//            let domandeArray = Array(domande)
//            let domandaObject = domandeArray[indexPath.row]
//            cell?.domanda =  domandaObject
//        }
//        return cell!
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        guard let categorie = self.verifica.categorie as? Set<CompagniaCategoria> else { return nil }
//        let categorieArray = Array(categorie)
//        return categorieArray[section].name
//    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        return 150
//        return UITableView.automaticDimension
//    }
//}
