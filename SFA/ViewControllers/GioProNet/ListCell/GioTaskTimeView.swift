//
//  GioTaskTimeView.swift
//  MGS
//
//  Created by Dani Tox on 21/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GioTaskTimeView: UIView {
    
    var time: GioProNetTask.GioProTime
    var task: GioProNetTask.TaskType
    
    lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Theme.current.textColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Theme.current.textColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let iView = UIImageView(frame: .zero)
        iView.contentMode = UIView.ContentMode.scaleAspectFit
        iView.translatesAutoresizingMaskIntoConstraints = false
        return iView
    }()
    
    var fullStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    init(time: GioProNetTask.GioProTime, task: GioProNetTask.TaskType) {
        self.time = time
        self.task = task
        super.init(frame: .zero)
        
        fullStack.addArrangedSubview(timeLabel)
        fullStack.addArrangedSubview(imageView)
        fullStack.addArrangedSubview(descriptionLabel)
        
        addSubview(fullStack)
        
        timeLabel.text = "\(time.stringValue)"
        descriptionLabel.text = task.stringValue
        if let emoji = task.emoji {
            imageView.image = emoji.image()
        } else {
            imageView.image = (task.imageName == nil) ? UIImage() :  UIImage(named: task.imageName!)
        }
        
        if task == .none {
            imageView.image = UIImage()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        fullStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        fullStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        fullStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        fullStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
