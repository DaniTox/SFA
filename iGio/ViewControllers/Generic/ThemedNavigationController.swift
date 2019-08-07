//
//  ThemedNavigationController.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class ThemedNavigationController: UINavigationController {

    var themeObserver : NSObjectProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.prefersLargeTitles = true
        
        themeObserver = NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main, using: { (notification) in
            UIView.animate(withDuration: 0.3, animations: { self.updateTheme() })
        })
        updateTheme()
    }
    
    func updateTheme() {
        self.navigationBar.barStyle = (Theme.current is LightTheme) ? .default : .black
    }

}
