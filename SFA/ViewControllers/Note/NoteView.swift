//
//  NoteView.swift
//  SFA
//
//  Created by Dani Tox on 11/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class NoteView: UIView {
    public var controller : UIViewController?
    
    lazy var textView : UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).withSize(20)
        view.backgroundColor = UIColor.darkGray
        
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 10
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var bottomBar : TextEditingBottomBar = {
        let bar = TextEditingBottomBar(textView: textView)
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = UIColor.black.lighter(by: 10)
        bar.layer.masksToBounds = true
        bar.layer.cornerRadius = 2
        return bar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Theme.current.backgroundColor
        addSubview(textView)
        //addSubview(bottomBar)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        textView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
//        bottomBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
//        bottomBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
//        bottomBar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
//        bottomBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
