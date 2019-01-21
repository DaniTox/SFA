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
    
    var themeObserver : NSObjectProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeObserver = NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main, using: { (notification) in
            UIView.animate(withDuration: 0.3, animations: { self.updateTheme() })
        })
        rootView.tableView.register(SettingsUserCell.self, forCellReuseIdentifier: "UserCell")
        rootView.tableView.register(BasicCell.self, forCellReuseIdentifier: "cell")
        rootView.tableView.register(SwitchCell.self, forCellReuseIdentifier: "switchCell")
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(themeObserver)
    }
    
    private func updateTheme() {
        rootView.tableView.backgroundColor = Theme.current.tableViewBackground
        rootView.tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rootView.tableView.reloadData()
    }
    
    @objc private func themeSwitchChanged(_ sender: UISwitch) {
        Theme.current = (sender.isOn) ? DarkTheme() : LightTheme()
    }
}

extension SettingsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headers = ["Account", "Generale"]
        return headers[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        case 1:
            return 50
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? SettingsUserCell
            cell?.userState = (userLogged == nil) ? .empty : .loggedIn
            return cell!
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BasicCell
                cell.textLabel?.text = "Notifiche"
                cell.accessoryType = .disclosureIndicator
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BasicCell
                cell.textLabel?.text = "I nostri Social"
                cell.accessoryType = .disclosureIndicator
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchCell
                cell.cellSwitch.isOn = (Theme.current is DarkTheme) ? true : false
                cell.cellSwitch.addTarget(self, action: #selector(themeSwitchChanged(_:)), for: .valueChanged)
                cell.textLabel?.text = "Tema scuro"
                return cell
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
                    if let popover = alert.popoverPresentationController {
                        let cell = tableView.cellForRow(at: indexPath)
                        popover.sourceView = cell
                        popover.sourceRect = cell?.bounds ?? .zero
                    }
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
        case 1:
            switch indexPath.row {
            case 0:
                let vc = NotificheVC()
                navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = SocialVC()
                vc.title = "Social"
                navigationController?.pushViewController(vc, animated: true)
            default:
                break
//                fatalError()
            }
        default:
            fatalError()
        }
    }
}
