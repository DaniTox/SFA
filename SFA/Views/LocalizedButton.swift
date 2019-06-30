//
//  LocalizedButton.swift
//  MGS
//
//  Created by Dani Tox on 20/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import SafariServices

class LocalizedButton: UIBouncyButton {
    
    var categoria: SitoCategoria
    var controller: UIViewController!
    
    init(controller: UIViewController, category: SitoCategoria) {
        self.categoria = category
        self.controller = controller
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
        autoSetImage()
        
    }
    
    init(category: SitoCategoria) {
        self.categoria = category
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
        autoSetImage()
    }
    
    func autoSetImage() {
        self.contentMode = UIView.ContentMode.scaleAspectFit
        
        switch self.categoria {
        case .facebook: self.setImage(#imageLiteral(resourceName: "fb"), for: .normal)
        case .instagram: self.setImage(#imageLiteral(resourceName: "instagram"), for: .normal)
        case .youtube: self.setImage(#imageLiteral(resourceName: "youtube"), for: .normal)
        default: break
        }
    }
    
    func fetchWebsites() -> [SitoObject] {
        let agent = SiteLocalizer()
        return agent.fetchLocalWebsites(type: categoria)
    }
    
    @objc private func tapped() {
        let sites = self.fetchWebsites()
        
        if sites.isEmpty {
            executeQuery(username: "mgslombardiaemilia")
        } else if sites.count == 1 {
            executeQuery(username: sites.first?.profileName)
        } else {
            let alert = UIAlertController(title: "Più opzioni", message: "Scegli il profilo da raggiungere", preferredStyle: .actionSheet)
            for site in sites {
                let action = UIAlertAction(title: "\(site.nome)", style: .default) { (action) in
                    self.executeQuery(username: site.profileName)
                }
                alert.addAction(action)
            }
            alert.addAction(UIAlertAction(title: "Annulla", style: .cancel, handler: nil))
            alert.popoverPresentationController?.sourceView = self
            
            let origin = CGRect(x: self.bounds.width / 2, y: self.bounds.height / 2, width: 0, height: 0)
            
            
            alert.popoverPresentationController?.sourceRect = origin
            self.controller.present(alert, animated: true)
        }
        
    }
    
    func executeQuery(username: String?) {
        guard let username = username else {
            controller.showError(withTitle: "Errore", andMessage: "Username non corretto")
            return
        }
        
        var query = ""
        var baseUrl = ""
        
        switch categoria {
        case .facebook:
            query = "fb://profile/\(username)"
            baseUrl = "https://it-it.facebook.com/\(username)"
        case .instagram:
            query = "instagram://user?username=\(username)"
            baseUrl = "https://instagram.com/\(username)"
        case .youtube:
            query = "youtube://www.youtube.com/channel/\(username)"
            baseUrl = "https://www.youtube.com/user/\(username)"
        default: break
        }
        
        guard let url = URL(string: query) else {
            controller.showError(withTitle: "Errore", andMessage: "Non è possibile raggiungere l'URL")
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            guard let newURL = URL(string: "\(baseUrl)") else {
                controller.showError(withTitle: "Errore", andMessage: "Non è possibile raggiungere l'URL")
                return
            }
            
            let vc = SFSafariViewController(url: newURL)
            controller.present(vc, animated: true)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
