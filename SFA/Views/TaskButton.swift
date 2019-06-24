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
    
    lazy var iconView : UIImageView = {
        let button = UIImageView()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    init(taskType: GioProNetTask.TaskType) {
        self.taskType = taskType
        super.init(frame: .zero)

        addSubview(iconView)
        addSubview(descriptionLabel)
    
        
        descriptionLabel.text = taskType.stringValue
        iconView.contentMode = UIView.ContentMode.scaleAspectFit
        
        if let emoji = taskType.emoji {
            iconView.image = emoji.image(with: 40)

        } else {
            let image = (taskType.imageName == nil) ? UIImage() : UIImage(named: taskType.imageName!)
            iconView.image = image
        }
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(emojiTouched))
        descriptionLabel.addGestureRecognizer(tapRecognizer)
        iconView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func emojiTouched() {
        print("Touched")
        self.sendActions(for: .touchUpInside)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        iconView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        iconView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
