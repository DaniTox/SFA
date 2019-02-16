//
//  GenderVCView.swift
//  SFA
//
//  Created by Dani Tox on 16/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GenderVCView: UIView {

    public var maleBox = GenderBox(gender: .boy, frame: .zero)
    public var girlBox = GenderBox(gender: .girl, frame: .zero)
    
    private var boxesStack : UIStackView = {
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
        backgroundColor = .white
        
        boxesStack.addArrangedSubview(maleBox)
        boxesStack.addArrangedSubview(girlBox)
        
        addSubview(boxesStack)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        boxesStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        boxesStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        boxesStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        boxesStack.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
