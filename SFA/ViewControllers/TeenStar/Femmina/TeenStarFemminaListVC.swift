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
        dataSource.dataChanged = {
            DispatchQueue.main.async {
                self.rootView.collectionView.reloadData()
            }
        }
        
        rootView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        rootView.collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "calendarCell")
        rootView.collectionView.dataSource = dataSource
        rootView.collectionView.delegate = dataSource
        rootView.collectionView.reloadData()
        
        let (month, year) = TSFAgent.getTodayComponents()
        rootView.monthButton.setTitle(month.monthString, for: .normal)
        rootView.yearButton.setTitle(String(year), for: .normal)
        
        rootView.monthButton.addTarget(self, action: #selector(monthButtonPressed), for: .touchUpInside)
        rootView.yearButton.addTarget(self, action: #selector(yearButtonPressed), for: .touchUpInside)
        
        dataSource.setUp()
    }
    
    @objc private func monthButtonPressed() {
        let alert = UIAlertController(title: "Seleziona il mese", message: nil, preferredStyle: .actionSheet)
        for monthInt in Date.monthsIntegers {
            let action = UIAlertAction(title: monthInt.monthString, style: .default) { (action) in
                self.rootView.monthButton.setTitle(monthInt.monthString, for: .normal)
                self.dataSource.set(month: action.title?.monthInteger ?? 0, year: nil)
            }
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: "Annulla", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc private func yearButtonPressed() {
        let agent = TSFAgent()
        let years = agent.getYearsList(basedOn: agent.getFarestDate())
        let alert = UIAlertController(title: "Seleziona l'anno", message: nil, preferredStyle: .actionSheet)
        
        for year in years {
            let action = UIAlertAction(title: String(year), style: .default) { (action) in
                self.rootView.yearButton.setTitle(String(year), for: .normal)
                self.dataSource.set(month: nil, year: Int(action.title ?? ""))
            }
            alert.addAction(action)
        }
        self.present(alert, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dataSource.refresh()
    }
 
    
    
}

