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

class HomeViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let dataSource = HomeViewDataSource()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.view.backgroundColor = Theme.current.tableViewBackground
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(calendarioButtonTapped))
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
        default: break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func calendarioButtonTapped() {
        guard let url = URL(string: "\(URLs.calendarioURL)") else { fatalError() }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
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
            let vc = TeenStarListVC<TeenStarMaschio>(type: .maschio)
            navigationController?.pushViewController(vc, animated: true)
        } else if user.gender == .girl {
            if user.ageScuola == .medie {
                let vc = TeenStarListVC<TeenStarMaschio>(type: .maschio)
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = TeenStarListVC<TeenStarFemmina>(type: .femmina)
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


