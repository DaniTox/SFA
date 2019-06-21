//
//  TaskButton.swift
//  MGS
//
//  Created by Dani Tox on 05/05/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class TaskButton: UIButton {
    var taskType: GioProNetTask.TaskType
    
    lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Theme.current.textColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        return label
    }()
    
//    var iconView: UIImageView = {
//        let view = UIImageView()
//        view.translatesAutoresizingMaskIntoConstraints = true
//        return view
//    }()
    
    

    lazy var iconButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var fullStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    init(taskType: GioProNetTask.TaskType) {
        self.taskType = taskType
        super.init(frame: .zero)

//
        fullStack.addArrangedSubview(iconButton)
        fullStack.addArrangedSubview(descriptionLabel)
//
        addSubview(fullStack)
        
        descriptionLabel.text = taskType.stringValue
        if let emoji = taskType.emoji {
            iconButton.setTitle(emoji, for: .normal)
            iconButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        } else {
            iconButton.setImage((taskType.imageName == nil) ? UIImage() : UIImage(named: taskType.imageName!), for: .normal)
        }
        
        iconButton.addTarget(self, action: #selector(emojiTouched), for: .touchUpInside)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(emojiTouched))
        descriptionLabel.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func emojiTouched() {
        print("Touched")
        self.sendActions(for: .touchUpInside)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        descriptionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        fullStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        fullStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        fullStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        fullStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
