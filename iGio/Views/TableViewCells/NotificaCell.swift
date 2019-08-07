//
//  NotificaCell.swift
//  SFA
//
//  Created by Dani Tox on 18/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class NotificaCell: UITableViewCell {

//    lazy var containerView : UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor.black.lighter(by: 7)
//        return view
//    }()
//
//    lazy var mainLabel : UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.preferredFont(forTextStyle: .body)
//        label.textColor = .white
//        label.textAlignment = .center
//        label.adjustsFontSizeToFitWidth = true
//        return label
//    }()
    
    var isNotificaSelected : Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        containerView.addSubview(mainLabel)
//        addSubview(containerView)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
