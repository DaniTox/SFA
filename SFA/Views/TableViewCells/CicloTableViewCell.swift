//
//  CicloTableViewCell.swift
//  SFA
//
//  Created by Dani Tox on 03/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class CicloTableViewCell: UITableViewCell {

    var colorSelected : CicloColor!
    
    var colorCollectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        colorCollectionView.register(CicloColorCollectionCell.self, forCellWithReuseIdentifier: "cell")
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        addSubview(colorCollectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        colorCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        colorCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        colorCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CicloTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CicloColorCollectionCell
        cell?.cicloColor = CicloColor.getColorFrom(str: CICLO_COLORS[indexPath.row])
        cell?.backgroundColor = .blue
        cell?.layer.masksToBounds = true
        cell?.layer.cornerRadius = 10
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : CGFloat = collectionView.bounds.width
        let height : CGFloat = 80
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected collectionView item")
    }
    
}
