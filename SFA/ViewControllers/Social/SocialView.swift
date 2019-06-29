//
//  SocialView.swift
//  SFA
//
//  Created by Dani Tox on 06/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class SocialView: UIView {

//    var instagramButton : LocalizedButton = {
//        let b = LocalizedButton(category: .instagram)
////        b.setTitle("Instagram", for: .normal)
//        b.backgroundColor = .clear
////        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
//        b.translatesAutoresizingMaskIntoConstraints = false
//
//        b.setImage(#imageLiteral(resourceName: "instagram"), for: .normal)
//        b.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
//
////        b.layer.masksToBounds = true
//        b.layer.cornerRadius = 10
//
//        b.layer.shadowColor = UIColor.black.cgColor
//        b.layer.shadowOffset = CGSize(width: 0, height: 0)
//        b.layer.shadowOpacity = 1.0
//        b.layer.shadowRadius = 10
//        b.layer.masksToBounds = false
//        return b
//    }()
//
//    lazy var instagramLabel : UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.preferredFont(forTextStyle: .headline)
//        label.textColor = .white
//        label.numberOfLines = 0
//        label.textAlignment = .left
//        label.text = "#mgslombardiaemila"
//        label.adjustsFontSizeToFitWidth = true
//        return label
//    }()
//
//    var facebookButton : LocalizedButton = {
//        let b = LocalizedButton(category: .facebook)
//        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = .clear
////        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
////        b.setTitle("Facebook", for: .normal)
//
//
//        b.setImage(#imageLiteral(resourceName: "fb"), for: .normal)
//        b.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
//
//        b.layer.cornerRadius = 10
//
//        b.layer.shadowColor = UIColor.black.cgColor
//        b.layer.shadowOffset = CGSize(width: 0, height: 0)
//        b.layer.shadowOpacity = 1.0
//        b.layer.shadowRadius = 10
//        b.layer.masksToBounds = false
//        return b
//    }()
//
//    lazy var facebookLabel : UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.preferredFont(forTextStyle: .headline)
//        label.textColor = .white
//        label.numberOfLines = 0
//        label.textAlignment = .left
//        label.text = "Seguici su Facebook!"
//        label.adjustsFontSizeToFitWidth = true
//        return label
//    }()
//
//    var youtubeButton : LocalizedButton = {
//        let b = LocalizedButton(category: .youtube)
//        b.translatesAutoresizingMaskIntoConstraints = false
//        b.backgroundColor = UIColor.clear
////        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
////        b.setTitle("YouTube", for: .normal)
//
//        b.setImage(#imageLiteral(resourceName: "youtube"), for: .normal)
//
//        b.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
//
//        b.layer.cornerRadius = 10
//
//        b.layer.shadowColor = UIColor.black.cgColor
//        b.layer.shadowOffset = CGSize(width: 0, height: 0)
//        b.layer.shadowOpacity = 1.0
//        b.layer.shadowRadius = 10
//        b.layer.masksToBounds = false
//        return b
//    }()
//
//    lazy var youtubeLabel : UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.preferredFont(forTextStyle: .headline)
//        label.numberOfLines = 0
//        label.textColor = .white
//        label.textAlignment = .left
//        label.text = "Guarda i nostri video!"
//        label.adjustsFontSizeToFitWidth = true
//        return label
//    }()
//
//    var stackView : UIStackView = {
//        let stack = UIStackView()
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .horizontal
//        stack.distribution = .fillProportionally
//        stack.alignment = .fill
//        stack.spacing = 0
//        return stack
//    }()
//
//    var iconsStack : UIStackView = {
//        let stack = UIStackView()
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .vertical
//        stack.distribution = .fillEqually
//        stack.alignment = .leading
//        stack.spacing = 30
//        return stack
//    }()
//
//    var textsStack : UIStackView = {
//        let stack = UIStackView()
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .vertical
//        stack.distribution = .fillEqually
//        stack.alignment = .fill
//        stack.spacing = 30
//        return stack
//    }()
    
    var facebookLayer: SocialStack = {
        let s = SocialStack(categoria: .facebook)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    var instagramLayer: SocialStack = {
        let s = SocialStack(categoria: .instagram)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    var youtubeLayer: SocialStack = {
        let s = SocialStack(categoria: .youtube)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    var fullStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Theme.current.controllerBackground
        
        fullStack.addArrangedSubview(facebookLayer)
        fullStack.addArrangedSubview(instagramLayer)
        fullStack.addArrangedSubview(youtubeLayer)
        
        addSubview(fullStack)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        fullStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fullStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        fullStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        fullStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
