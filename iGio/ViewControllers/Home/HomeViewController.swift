//
//  HostViewControleller.swift
//  SFA
//
//  Created by Dani Tox on 24/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift
import SafariServices
import DXNetworkManager
import SwiftUI

class HomeViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let dataSource = HomeViewDataSource()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.view.backgroundColor = Theme.current.tableViewBackground
        
        let rightButton = UIBarButtonItem(image: #imageLiteral(resourceName: "calendar"), style: .plain, target: self, action: #selector(calendarioButtonTapped(_:)))
        self.navigationItem.setRightBarButton(rightButton, animated: true)
        
        collectionView.register(HomeItemCell.self, forCellWithReuseIdentifier: "mainCell")
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        dataSource.update()
        collectionView.reloadData()
        
        NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main) { (notif) in
            self.view.backgroundColor = Theme.current.tableViewBackground
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.update()
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        return .init(width: width / 2 - 15, height: height / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource.items[indexPath.row]
        print("Selected \(item.name)")
        
        switch item.idNumber {
        case 0: showNoteListController()
        case 1: showTeenStarController()
        case 2: showGioProNetController()
        case 3: showRegolaController()
        case 4: showVerificaCompagniaController()
        case 5: showRegolaController()
        case 6: showRegolaController()
        case 7: showAngeloCustode()
        default: break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func calendarioButtonTapped(_ sender: UIBarButtonItem) {
        let agent = SiteLocalizer()
        let sites = agent.fetchLocalWebsites(type: .calendario)
        
        if sites.isEmpty {
            guard let url = URL(string: "\(AppURL.calendario)") else { return }
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else if sites.count == 1 {
            guard let url = sites.first?.url else { return }
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Più opzioni", message: "Quale calendario vuoi raggiungere?", preferredStyle: .actionSheet)
            for site in sites {
                alert.addAction(UIAlertAction(title: "\(site.nome)", style: .default, handler: { (action) in
                    DispatchQueue.main.async {
                        guard let url = site.url else { return }
                        let vc = SFSafariViewController(url: url)
                        self.present(vc, animated: true)
                    }
                }))
            }
            alert.addAction(UIAlertAction(title: "Annulla", style: .cancel, handler: nil))
            alert.popoverPresentationController?.barButtonItem = sender
            self.present(alert, animated: true)
        }
    
    }
    
    @objc func showAngeloCustode() {
        switch User.currentUser().ageScuola {
        case .medie:
            break
        default:
            if #available(iOS 14, *) {
                let view = NavigationView { AngeloView(donePressed: dismissPresentedVC) }
                let vc = UIHostingController(rootView: view)
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    private func dismissPresentedVC() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func showRegolaController() {
        switch User.currentUser().ageScuola {
        case .medie:
            let vc = RegolaCategorieVC(regolaType: .medie)
            navigationController?.pushViewController(vc, animated: true)
        case .biennio:
            let vc = RegolaCategorieVC(regolaType: .biennio)
            navigationController?.pushViewController(vc, animated: true)
        case .triennio:
            let vc = RiassuntoVC(style: .grouped, regolaType: ScuolaType.triennio)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func showNoteListController() {
        let noteListVC = NoteListVC()
        navigationController?.pushViewController(noteListVC, animated: true)
    }
    
    private func showTeenStarController() {
        let user = User.currentUser()
        if user.gender == .boy {
            let vc = TeenStarMaschioListVC()
            navigationController?.pushViewController(vc, animated: true)
        } else if user.gender == .girl {
            if user.ageScuola == .medie {
                let vc = TeenStarMaschioListVC()
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = TeenStarFemminaListVC()
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    @objc private func showGioProNetController() {
        navigationController?.pushViewController(GioProListVC(), animated: true)
    }
    
    @objc private func showVerificaCompagniaController() {
        let ageScuola = User.currentUser().ageScuola
        let vc = VerificaCompagniaVC(type: ageScuola)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


