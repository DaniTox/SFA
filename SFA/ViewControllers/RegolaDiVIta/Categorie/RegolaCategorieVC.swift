//
//  RegolaCategorieVC.swift
//  SFA
//
//  Created by Dani Tox on 25/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class RegolaCategorieVC: UIViewController, HasCustomView {
    typealias CustomView = RegoleCategorieView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var regola: RegolaVita?
    let regolaFetcherModel = RegolaFetcherModel.shared
    
    var observer : NSObjectProtocol!
    
    init(regolaType: ScuolaType) {
        super.init(nibName: nil, bundle: nil)
        RegolaFetcherModel.shared.createIfNotPresent()
        self.regola = regolaFetcherModel.getRegola(type: regolaType)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observer = NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main, using: { (notification) in
            self.updateTheme()
        })
        
        title = "Agenda dell'allegria e della santità"
        rootView.tableView.register(RegolaDomandaCell.self, forCellReuseIdentifier: "cell")
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.refreshControl.addTarget(self, action: #selector(tablePulled), for: .valueChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.tableView.reloadData()
    }
    
    private func updateTheme() {
        rootView.tableView.backgroundColor = Theme.current.tableViewBackground
        rootView.tableView.reloadData()
    }
    
    @objc private func tablePulled() {
        rootView.tableView.reloadData()
    }

}

extension RegolaCategorieVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return regola?.categorie.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categoria = self.regola?.categorie[section]
        return categoria?.domande.count ?? 0
    }

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return self.regola?.categorie[section].nome
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let text = self.regola?.categorie[section].nome
        let view = HeaderView()
        view.mainLabel.text = text
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RegolaDomandaCell
        let categoria = self.regola?.categorie[indexPath.section]
        if let domanda = categoria?.domande[indexPath.row] {
            cell.mainLabel.text = domanda.domanda
            cell.answerLabel.text = (domanda.risposta != nil && !domanda.risposta!.isEmpty) ? domanda.risposta : "Nessuna risposta"
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoria = self.regola?.categorie[indexPath.section]
        if let domanda = categoria?.domande[indexPath.row] {
            let vc = EditRispostaVC(domanda: domanda)
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
