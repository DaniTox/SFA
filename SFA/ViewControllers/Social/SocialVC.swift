//
//  SocialVC.swift
//  SFA
//
//  Created by Dani Tox on 06/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit
import SafariServices

class SocialVC: UIViewController, HasCustomView {
    typealias CustomView = SocialView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Social"
        NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main) { (notification) in
            self.updateTheme()
        }

        rootView.instagranmButton.controller = self
        rootView.facebookButton.controller = self
        rootView.youtubeButton.controller = self
    }
    
    private func updateTheme() {
        self.rootView.backgroundColor = Theme.current.controllerBackground
    }
    

}
