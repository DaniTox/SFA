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

    private var tasks: [GioProNetTask] = [ .facebook, .instagram, .youtube, .whatsapp,
                                   .internet, .videogiochi, .musica, .sport,
                                   .scuola, .famiglia, .amici, .notte
                                ]
    
    var taskSelected: GioProNetTask?
    
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
        let button = TaskButton(imageNamed: imagesNames[index], task: tasks[index])
        button.addTarget(self, action: #selector(taskButtonTouched(_:)), for: .touchUpInside)
        return button
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func updateView(for task: GioProNetTask) {
        let stacks = [firstStack, secondStack, thirdStack]
        for stack in stacks {
            for button in stack.arrangedSubviews {
                guard let taskButton = button as? TaskButton else { continue }
                
                if taskButton.task == task {
                    taskButton.backgroundColor = UIColor.green
                } else {
                    taskButton.backgroundColor = UIColor.clear
                }
            }
        }
        
    }
    
    public func setTask(_ task: GioProNetTask) {
        self.taskSelected = task
        updateView(for: task)
    }
    
    @objc private func taskButtonTouched(_ sender: TaskButton) {
        self.taskSelected = sender.task
        updateView(for: sender.task)
    }
    
//    @objc func facebookTouched(_ sender: UIButton) {
//
//    }
//    @objc func instagramTouched(_ sender: UIButton) {
//
//    }
//    @objc func youtubeTouched(_ sender: UIButton) {
//
//    }
//    @objc func whatsappTouched(_ sender: UIButton) {
//
//    }
//    @objc func internetTouched(_ sender: UIButton) {
//
//    }
//    @objc func giochiTouched(_ sender: UIButton) {
//
//    }
//    @objc func musicaTouched(_ sender: UIButton) {
//
//    }
//    @objc func sportTouched(_ sender: UIButton) {
//
//    }
//    @objc func scuolaTouched(_ sender: UIButton) {
//
//    }
//    @objc func famigliaTouched(_ sender: UIButton) {
//
//    }
//    @objc func amiciTouched(_ sender: UIButton) {
//
//    }
//    @objc func notteTouched(_ sender: UIButton) {
//
//    }
    
}
