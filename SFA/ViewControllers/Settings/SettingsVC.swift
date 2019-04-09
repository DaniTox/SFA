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
        rootView.tableView.register(BoldCell.self, forCellReuseIdentifier: "boldCell")
        rootView.tableView.register(SwitchCell.self, forCellReuseIdentifier: "switchCell")
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(themeObserver as Any)
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
            return 4
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 130
        case 1:
            return 100
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "boldCell") as? BoldCell
            cell?.mainLabel.text = "Backup (ancora in sviluppo)"
            return cell!
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "boldCell") as! BoldCell
                cell.mainLabel.text = "Notifiche"
                cell.accessoryType = .disclosureIndicator
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "boldCell") as! BoldCell
                cell.mainLabel.text = "I nostri Social"
                cell.accessoryType = .disclosureIndicator
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchCell
                cell.cellSwitch.isOn = (Theme.current is DarkTheme) ? true : false
                cell.cellSwitch.addTarget(self, action: #selector(themeSwitchChanged(_:)), for: .valueChanged)
                cell.mainLabel.text = "Tema scuro"
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "boldCell") as! BoldCell
                cell.mainLabel.text = "Tipo di scuola"
                cell.accessoryType = .disclosureIndicator
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
           break
        case 1:
            switch indexPath.row {
            case 0:
                let vc = NotificheVC()
                navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = SocialVC()
                vc.title = "Social"
                navigationController?.pushViewController(vc, animated: true)
            case 3:
                let vc = GradoScuolaVC()
                vc.finishAction = { [weak self] in
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
                navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        default:
            fatalError()
        }
    }
}
