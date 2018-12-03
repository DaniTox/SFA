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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 1))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        rootView.refreshControl.addTarget(self, action: #selector(tablePulled), for: .valueChanged)
    }
    
    @objc private func tablePulled() {
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
}

extension DomandeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        if indexPath.row == 0 {
            cell.textLabel?.text = domande[indexPath.section].domanda
            cell.selectionStyle = .none
            cell.textLabel?.textColor = UIColor.black
        } else {
            cell.textLabel?.text = domande[indexPath.section].risposta ?? "Nessuna"
            cell.selectionStyle = .default
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.textColor = UIColor.lightGray
        }
        return cell
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
        let domanda = self.domande[indexPath.section]
        let vc = EditRispostaVC()
        vc.domandaObject = domanda
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
