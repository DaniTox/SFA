//
//  GioNetListCellDataSource.swift
//  MGS
//
//  Created by Dani Tox on 15/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GioNetListCellDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var gioItem: GioProNet?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GioProNetTask.GioProTime.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GioCollectionListCell
        cell.task = gioItem?.getTask(at: GioProNetTask.GioProTime.allCases[indexPath.row])
        return cell
    }
    
}
