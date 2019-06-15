//
//  GioProListCell.swift
//  MGS
//
//  Created by Dani Tox on 15/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GioProListCell: UITableViewCell {

    var collectionView: UICollectionView = {
        let c = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    var gioItem: GioProNet? {
        didSet {
            dataSource.gioItem = gioItem
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var dataSource = GioNetListCellDataSource()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.register(GioCollectionListCell.self, forCellWithReuseIdentifier: "cell")
        
        addSubview(collectionView)
        self.backgroundColor = Theme.current.backgroundColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GioProListCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 3 - 30
        let height = width
        
        return .init(width: width, height: height)
    }
}
