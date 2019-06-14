//
//  GioProNetCell.swift
//  MGS
//
//  Created by Dani Tox on 05/05/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GioProNetCell: BoldCell {
    
    private var imagesNames: [String] = ["facebook", "instagram", "youtube", "whatsapp",
                                 "internet", "giochi", "musica", "sport",
                                 "scuola", "famiglia", "amici", "notte"
                                 ]
    
    var cellTask: GioProNetTask? {
        didSet {
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
    
    private var thirdStack : UIStackView = {
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
        
        for index in 0...3 {
            firstStack.addArrangedSubview(getButton(index: index))
        }
        
        for index in 4...7 {
            secondStack.addArrangedSubview(getButton(index: index))
        }
        
        for index in 8...11 {
            thirdStack.addArrangedSubview(getButton(index: index))
        }
        
        fullStack.addArrangedSubview(firstStack)
        fullStack.addArrangedSubview(secondStack)
        fullStack.addArrangedSubview(thirdStack)
        
        addSubview(fullStack)
    }
    
    private func getButton(index: Int) -> TaskButton {
        let button = TaskButton(imageNamed: imagesNames[index], taskType: GioProNetTask.TaskType.allCases[index])
        button.addTarget(self, action: #selector(taskButtonTouched(_:)), for: .touchUpInside)
        return button
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func updateView() {
        let stacks = [firstStack, secondStack, thirdStack]
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
    }
    
}
