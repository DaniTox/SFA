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
    
    init(time: GioProNetTask.GioProTime, task: GioProNetTask.TaskType) {
        self.time = time
        self.task = task
        super.init(frame: .zero)

        addSubview(timeLabel)
        addSubview(imageView)
        addSubview(descriptionLabel)
        
        
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
        
        timeLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        
        imageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        imageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true

        
        descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
