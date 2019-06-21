//
//  GioProListCell.swift
//  MGS
//
//  Created by Dani Tox on 15/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GioProListCell: UITableViewCell {

    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textColor = Theme.current.textColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var hStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    
    
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = Theme.current.backgroundColor
        return view
    }()
    
    var gioItem: GioProNet? {
        didSet {
            DispatchQueue.main.async {
                self.titleLabel.text = self.gioItem?.date.stringValue
                self.updateView()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        
        containerView.addSubview(titleLabel)
        containerView.addSubview(hStack)
        addSubview(containerView)
    
        self.backgroundColor = .clear
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
    
    func updateView() {
        guard let item = self.gioItem else { return }
        for time in GioProNetTask.GioProTime.allCases {
            let taskView = GioTaskTimeView(time: time, task: item.getTask(at: time).taskType)
            hStack.addArrangedSubview(taskView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
