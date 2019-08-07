//
//  HomeViewDataSource.swift
//  MGS
//
//  Created by Dani Tox on 09/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class HomeViewDataSource: NSObject, UICollectionViewDataSource {
    
    var items: [HomeItem] = []
    
    func update() {
        let user = User.currentUser()
        self.items = allHomeItems.filter { $0.allowedAge.contains(user.ageScuola) && $0.allowedGenders.contains(user.gender) }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! HomeItemCell
        cell.item = items[indexPath.row]
        return cell
    }
    
    
    
}
