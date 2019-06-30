//
//  WelcomeView.swift
//  SFA
//
//  Created by Dani Tox on 18/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class WelcomeView: UIView {
        
    lazy var ignoraButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Inizia", for: .normal)
//        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.backgroundColor = .red
        button.setTitleColor(.black, for: .normal)
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Benvenuto in MGS!"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var colorView: UIImageView = {
        let c = UIImageView()
        c.contentMode = UIView.ContentMode.scaleAspectFit
//        c.layer.masksToBounds = true
        c.layer.cornerRadius = 10
        
        c.layer.shadowColor = LightTheme().shadowColor.cgColor
        c.layer.shadowOffset = CGSize(width: 0, height: 0)
        c.layer.shadowOpacity = 1.0
        c.layer.shadowRadius = 10
        c.layer.masksToBounds = false

        return c
    }()
    
    lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = ""
        for i in 0..<5 {
            label.text = label.text?.appending("Descrizione App\n")
        }
        
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
        addSubview(ignoraButton)
        addSubview(colorView)
        addSubview(descriptionLabel)
        
        colorView.image = #imageLiteral(resourceName: "igio")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        let viewWidth = self.frame.width
        
        titleLabel.frame.size = CGSize(width: 200, height: 70)
        colorView.frame.size = CGSize(width: 100, height: 100)
        descriptionLabel.frame.size = CGSize(width: viewWidth - 40, height: 300)
        ignoraButton.frame.size = CGSize(width: 120, height: 70)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        ignoraButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
//        ignoraButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
