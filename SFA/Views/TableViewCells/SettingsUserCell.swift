//
//  SettingsUserCell.swift
//  SFA
//
//  Created by Daniel Fortesque on 04/01/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

enum UserState {
    case loggedIn
    case empty
}

class SettingsUserCell: BasicCell {

    var mainLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.callout)
        label.textColor = Theme.current.cellTitleColor
        return label
    }()
    
    var descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Theme.current.cellSubtitleColor
        return label
    }()
    
    var labelsStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = UIStackView.Alignment.fill
        stack.distribution = UIStackView.Distribution.fillProportionally
        return stack
    }()
    
    var userState: UserState? {
        didSet {
            guard let state = userState else { return }
            if state == .loggedIn && userLogged != nil {
                DispatchQueue.main.async {
                    self.mainLabel.text = "\(userLogged!.name) \(userLogged!.cognome)"
                    self.descriptionLabel.text = "\(userLogged!.email)"
                }
            } else {
                DispatchQueue.main.async {
                    self.mainLabel.text = "Accedi o Registrati"
                    self.mainLabel.font = UIFont.boldSystemFont(ofSize: 25)
                    self.descriptionLabel.text = "Esegui l'accesso per salvare i tuoi dati"
                    self.accessoryType = .disclosureIndicator
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        labelsStack.addArrangedSubview(mainLabel)
        labelsStack.addArrangedSubview(descriptionLabel)
        addSubview(labelsStack)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        labelsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        labelsStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        labelsStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75).isActive = true
    }
}
