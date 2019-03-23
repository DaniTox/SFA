//
//  TeenStarCell.swift
//  MGS
//
//  Created by Dani Tox on 23/03/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class TeenStarCell : BoldCell {
    
    lazy private var emozione8Label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Theme.current.textColor
        label.textAlignment = .center
        label.text = "8:00"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy private var emozione14Label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Theme.current.textColor
        label.textAlignment = .center
        label.text = "14:00"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy private var emozione20Label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Theme.current.textColor
        label.textAlignment = .center
        label.text = "20:00"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var emoji8 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body).withSize(40)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "🤣"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var emoji14 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body).withSize(40)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "🤣"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var emoji20 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body).withSize(40)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "🤣"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    var stack8 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 0
        return stack
    }()
    
    var stack14 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 0
        return stack
    }()
    
    var stack20 : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 0
        return stack
    }()
    
    var fullStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    var sentimenti: SentimentoTable?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainLabel.textAlignment = .center
        
        stack8.addArrangedSubview(emozione8Label)
        stack8.addArrangedSubview(emoji8)
        
        stack14.addArrangedSubview(emozione14Label)
        stack14.addArrangedSubview(emoji14)
        
        stack20.addArrangedSubview(emozione20Label)
        stack20.addArrangedSubview(emoji20)
        
        fullStack.addArrangedSubview(stack8)
        fullStack.addArrangedSubview(stack14)
        fullStack.addArrangedSubview(stack20)
        
        containerView.addSubview(fullStack)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.emozione8Label.textColor = Theme.current.textColor
        self.emozione14Label.textColor = Theme.current.textColor
        self.emozione20Label.textColor = Theme.current.textColor
    }
    
    override func layoutSubviews() {
        let margins = contentView.layoutMarginsGuide
        if UIDevice.current.deviceType == .pad {
            containerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 5).isActive = true
            containerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -5).isActive = true
            containerView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -5).isActive = true
            containerView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 5).isActive = true
        } else {
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        }
        
        mainLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        mainLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        mainLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.4).isActive = true
        
        
        fullStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        fullStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        fullStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        fullStack.topAnchor.constraint(equalTo: mainLabel.bottomAnchor).isActive = true
    }
    
    func setSentimenti(table: SentimentoTable) {
        
        self.emoji8.text = self.getEmojiFrom(emozione: table.sentimentoOre8)
        self.emoji14.text = self.getEmojiFrom(emozione: table.sentimentoOre14)
        self.emoji20.text = self.getEmojiFrom(emozione: table.sentimentoOre20)
        
    }
    
    private func getEmojiFrom(emozione: Emozione) -> String {
        switch emozione {
        case .fiducioso:
            return "😌"
        case .aggressività:
            return "😡"
        case .paura:
            return "😱"
        case .tristezza:
            return "😢"
        case .gioia:
            return "😁"
        case .equilibrio:
            return "😐"
        default:
            return ""
        }
    }
    
}
