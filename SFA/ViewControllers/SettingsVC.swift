//
//  SettingsVC.swift
//  SFA
//
//  Created by Dani Tox on 04/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, HasCustomView {
    typealias CustomView = SettingsView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rootView.tableView.reloadData()
    }
    
}

extension SettingsVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            if userLogged != nil {
                cell?.textLabel?.text = "\(userLogged!.name) \(userLogged!.cognome)"
            } else {
                cell?.textLabel?.text = "Accedi o Registrati"
                cell?.accessoryType = .disclosureIndicator
            }
            return cell!
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if userLogged == nil {
                let alert = UIAlertController(title: "Quale azione vorresti compiere?", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Annulla", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Accedi", style: .default, handler: { (action) in
                    let vc = LoginVC()
                    vc.successCompletion = { loginVc in
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }))
                alert.addAction(UIAlertAction(title: "Registrati", style: .default, handler: { (action) in
                    let vc = RegisterVC()
                    vc.successCompletion = { registerVC in
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }))
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            } else {
                let alert = UIAlertController(title: "Vuoi veramente uscire dal tuo account?", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Annulla", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Esci", style: .destructive, handler: { (action) in
                    userLogged = nil
                    tableView.reloadData()
                }))
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            }
        default:
            fatalError()
        }
    }
}
