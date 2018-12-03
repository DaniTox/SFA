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
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.backgroundColor = UIColor.yellow.lighter()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(domandaLabel)
        addSubview(textView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        domandaLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        domandaLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        domandaLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        domandaLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        textView.topAnchor.constraint(equalTo: domandaLabel.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
