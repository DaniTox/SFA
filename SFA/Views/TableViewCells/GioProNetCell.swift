//
//  GioProNetCell.swift
//  MGS
//
//  Created by Dani Tox on 05/05/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GioProNetCell: BoldCell {
    
    var cellTask: GioProNetTask? {
        didSet {
            cellTime = cellTask?.time
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    var cellTime: GioProNetTask.GioProTime?
    
    var taskSelectedHandler: ((GioProNetTask.GioProTime, GioProNetTask.TaskType) -> Void)? = nil
    
    private var firstStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    private var secondStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    private var fullStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        for index in 0..<3 {
            firstStack.addArrangedSubview(getButton(index: index))
        }
        
        for index in 3..<6 {
            secondStack.addArrangedSubview(getButton(index: index))
        }
        
        fullStack.addArrangedSubview(firstStack)
        fullStack.addArrangedSubview(secondStack)
        
        addSubview(fullStack)
    }
    
    private func getButton(index: Int) -> TaskButton {
        let type = GioProNetTask.TaskType.allCases[index]
        let button = TaskButton(taskType: type)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10

        button.addTarget(self, action: #selector(taskButtonTouched(_:)), for: .touchUpInside)
        return button
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        fullStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        fullStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        fullStack.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        fullStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    private func updateView() {
        let stacks = [firstStack, secondStack]
        for stack in stacks {
            for button in stack.arrangedSubviews {
                guard let taskButton = button as? TaskButton else { continue }
                
                if taskButton.taskType == cellTask?.taskType {
                    taskButton.backgroundColor = UIColor.green
                } else {
                    taskButton.backgroundColor = UIColor.clear
                }
            }
        }
        
    }
    
    @objc private func taskButtonTouched(_ sender: TaskButton) {
        if let time = self.cellTime {
            taskSelectedHandler?(time, sender.taskType)
        }
        updateView()
    }
    
}
