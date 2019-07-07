//
//  NotificheView.swift
//  SFA
//
//  Created by Dani Tox on 17/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class NotificheOnBoardingVC : NotificheVC, OrderedFlowController {
    var orderingCoordinator: OrderedFlowCoordinator?
    var showCurrentValue: Bool = true
    
    lazy var doneButton : UIBouncyButton = {
        let button = UIBouncyButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline).withSize(25)
        button.setTitle("Fine", for: .normal)
        button.backgroundColor = UIColor.darkGray.darker()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(doneButton)
        doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        doneButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: tableView.frame.height / 8).isActive = true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableHeight = tableView.frame.height
        let cellHeight = tableHeight / CGFloat(Notifiche.NotificheType.allCases.count + 2)
        return cellHeight
    }
    
    @objc func doneAction() {
        orderingCoordinator?.next()
    }
    
}
