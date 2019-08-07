//
//  EditRispostaVC.swift
//  SFA
//
//  Created by Dani Tox on 26/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class EditRispostaView : UIView {
    
    lazy var domandaLabel : UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textColor = Theme.current.textColor
        label.backgroundColor = Theme.current.backgroundColor
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.55
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textView : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = Theme.current.backgroundColor.cgColor
        textView.backgroundColor = Theme.current.backgroundColor
        textView.textColor = Theme.current.textColor
        
        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 15
        
        textView.layer.shadowColor = Theme.current.shadowColor.cgColor
        textView.layer.shadowOffset = CGSize(width: 0, height: 0)
        textView.layer.shadowOpacity = 1.0
        textView.layer.shadowRadius = 10
        textView.layer.masksToBounds = false
        return textView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Theme.current.controllerBackground
        addSubview(domandaLabel)
        addSubview(textView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        domandaLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        domandaLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        domandaLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        domandaLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        textView.topAnchor.constraint(equalTo: domandaLabel.bottomAnchor, constant: 10).isActive = true
        textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
