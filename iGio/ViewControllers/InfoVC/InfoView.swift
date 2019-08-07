//
//  InfoView.swift
//  MGS
//
//  Created by Dani Tox on 04/05/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class InfoView: UIView {
    
    var textView: UITextView = {
        let tView = UITextView()
        tView.translatesAutoresizingMaskIntoConstraints = false
        tView.isEditable = false
        tView.backgroundColor = Theme.current.backgroundColor
        return tView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
