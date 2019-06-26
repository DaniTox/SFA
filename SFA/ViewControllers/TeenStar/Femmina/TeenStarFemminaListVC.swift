//
//  TeenStarFemminaListVC.swift
//  MGS
//
//  Created by Dani Tox on 25/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class TeenStarFemminaListVC: UIViewController, HasCustomView {
    typealias CustomView = TSFemminaListView
    override func loadView() {
        self.view = CustomView()
    }
    
    var dataSource = TeenStarFemminaSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        rootView.collectionView.dataSource = dataSource
        rootView.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}
