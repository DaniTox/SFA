//
//  DomandeVC.swift
//  SFA
//
//  Created by Dani Tox on 25/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class DomandeVC: UIViewController, HasCustomView {
    typealias CustomView = DomandeView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var tableView : UITableView { return rootView.tableView }
    var domande : [Domanda] = []
    var selectedCategory : Categoria?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main) { (notification) in
            self.updateTheme()
        }
        
        tableView.tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 1))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BoldCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TextCell.self, forCellReuseIdentifier: "textCell")
        rootView.refreshControl.addTarget(self, action: #selector(tablePulled), for: .valueChanged)
        
//        getDomande()
    }
    
    private func updateTheme() {
        self.rootView.tableView.backgroundColor = Theme.current.tableViewBackground
        self.rootView.tableView.reloadData()
    }
    
    @objc private func tablePulled() {
        updateTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTable()
    }
    
    private func updateTable() {
//        getDomande()
        tableView.reloadData()
    }
    
//    private func getDomande() {
//        guard let categoria = self.selectedCategory else { return }
//        let domande = RegolaFetcherModel.shared.getDomande(from: categoria)
//        self.domande = domande.sorted(by: {$0.id < $1.id })
//        let undomande = selectedCategory?.domande as? Set<Domanda>
//        let domanda = undomande!.first(where: {$0.domanda == "Versione"})
//        print("\(String(describing: domanda?.domanda)): \(String(describing: domanda?.risposta))")
//    }
}

extension DomandeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BoldCell
            cell.mainLabel.text = domande[indexPath.section].domanda
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! TextCell
            if let text = domande[indexPath.section].risposta, !text.isEmpty {
                cell.mainLabel.text = text
            } else {
                cell.mainLabel.text = "Campo vuoto"
            }
            cell.selectionStyle = .default
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return domande.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 { return }
        tableView.deselectRow(at: indexPath, animated: true)
//        let domanda = self.domande[indexPath.section]
//        let vc = EditRispostaVC(domanda: domanda)
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
