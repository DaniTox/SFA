//
//  TSFemminaListView.swift
//  MGS
//
//  Created by Dani Tox on 25/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class TSFemminaListView: UIView {
    
    var collectionView: UICollectionView = {
        let c = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    lazy var monthButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.setTitleColor(Theme.current.textColor, for: .normal)
        button.backgroundColor = Theme.current.backgroundColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var yearButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.setTitleColor(Theme.current.textColor, for: .normal)
        button.backgroundColor = Theme.current.backgroundColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    var buttonsStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Theme.current.tableViewBackground
        
        buttonsStack.addArrangedSubview(monthButton)
        buttonsStack.addArrangedSubview(yearButton)
        
        addSubview(buttonsStack)
        addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        buttonsStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        buttonsStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        buttonsStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        buttonsStack.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 15).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
