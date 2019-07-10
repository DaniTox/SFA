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
        c.translatesAutoresizingMaskIntoConstraints = false
        c.contentMode = UIView.ContentMode.scaleAspectFit
        //        c.layer.masksToBounds = true
        c.layer.cornerRadius = 10
        
        c.layer.shadowColor = UIColor.gray.cgColor
        c.layer.shadowOffset = CGSize(width: 0, height: 0)
        c.layer.shadowOpacity = 1.0
        c.layer.shadowRadius = 10
        c.layer.masksToBounds = false
        
        return c
    }()
    
    lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline).withSize(25)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = """
        La vita dei giovani affronta oggi una nuova sfida: interagire con un mondo reale e virtuale in cui si addentrano da soli come in un continente sconosciuto (Papa Francesco).
        Con iGio, vi diamo la #bussola!
        """
        //        for i in 0..<5 {
        //            label.text = label.text?.appending("Descrizione App\n")
        //        }
        
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    var allConstraints: [NSLayoutConstraint] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(ignoraButton)
        addSubview(colorView)
        addSubview(descriptionLabel)
        
        colorView.image = #imageLiteral(resourceName: "igio")
        
        [titleLabel, ignoraButton, colorView, descriptionLabel].forEach { $0.alpha = 0 }
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        let viewWidth = self.frame.width
        
        titleLabel.frame.size = CGSize(width: 200, height: 70)
        colorView.frame.size = CGSize(width: 100, height: 100)
        descriptionLabel.frame.size = CGSize(width: viewWidth - 40, height: 300)
        ignoraButton.frame.size = CGSize(width: 120, height: 70)
        
        
        allConstraints = [
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            
            colorView.heightAnchor.constraint(equalToConstant: 100),
            colorView.widthAnchor.constraint(equalToConstant: 100),
            colorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            //            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            descriptionLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 30),
            
            ignoraButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            ignoraButton.heightAnchor.constraint(equalToConstant: 50),
            ignoraButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            ignoraButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
        ]
        
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
