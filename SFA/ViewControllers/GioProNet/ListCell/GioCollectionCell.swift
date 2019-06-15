//
//  GioCollectionCell.swift
//  MGS
//
//  Created by Dani Tox on 15/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GioCollectionListCell : UICollectionViewCell {
    
    lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Theme.current.cellTitleColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var taskLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Theme.current.cellTitleColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var fullStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        return stack
    }()
    
    var task: GioProNetTask? {
        didSet {
            guard let task = task else { return }
            timeLabel.text = "\(task.time.stringValue)"
            taskLabel.text = "\(task.taskType.stringValue)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        
        fullStack.addArrangedSubview(timeLabel)
        fullStack.addArrangedSubview(taskLabel)
        
        addSubview(fullStack)
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
