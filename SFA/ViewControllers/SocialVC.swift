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
        NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main) { (notification) in
            self.updateTheme()
        }
        
        rootView.instagranmButton.addTarget(self, action: #selector(openInstagram), for: .touchUpInside)
        rootView.facebookButton.addTarget(self, action: #selector(openFacebook), for: .touchUpInside)
        rootView.youtubeButton.addTarget(self, action: #selector(openYouTube), for: .touchUpInside)
    }
    
    private func updateTheme() {
        self.rootView.backgroundColor = Theme.current.controllerBackground
    }
    
    @objc func openInstagram() {
        let scheme = "instagram://user?username=mgslombardiaemilia"
        let url = URL(string: scheme)!
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            let url = URL(string: "https://instagram.com/mgslombardiaemilia?utm_source=ig_profile_share&igshid=w4zpidun5g2n")!
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
    
    @objc private func openFacebook() {
        let scheme = "fb://profile/mgslombardiaemilia"
        let url = URL(string: scheme)!
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            let url = URL(string: "https://it-it.facebook.com/mgslombardiaemilia")!
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
    
    @objc private func openYouTube() {
        let scheme = "youtube://www.youtube.com/channel/mgslombardiaemilia"
        guard let url = URL(string: scheme) else {
            fatalError("Errore nella creazione dell'url")
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            guard let directUrl = URL(string: "https://www.youtube.com/user/mgslombardiaemilia") else {
                fatalError("Errore creazione url web")
            }
            let vc = SFSafariViewController(url: directUrl)
            present(vc, animated: true)
        }
    }
}
