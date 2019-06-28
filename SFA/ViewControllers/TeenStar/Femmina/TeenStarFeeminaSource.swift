//
//  TeenStarFeeminaSource.swift
//  MGS
//
//  Created by Dani Tox on 25/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class TeenStarFemminaSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var selectedMonth: Int = 0 {
        didSet {
            if selectedMonth <= 0 { return }
            if selectedYear <= 0 { return }
            let calendar = Calendar.current
            var components = calendar.dateComponents([.month, .year], from: currentDate)
            components.month = selectedMonth
            if let newDate = calendar.date(from: components) {
                self.currentDate = newDate
            }
        }
    }
    
    var selectedYear: Int = 0 {
        didSet {
            if selectedYear <= 0 { return }
            if selectedMonth <= 0 { return }
            
            let calendar = Calendar.current
            var components = calendar.dateComponents([.month, .year], from: currentDate)
            components.year = selectedYear
            if let newDate = calendar.date(from: components) {
                self.currentDate = newDate
            }
        }
    }
    
    var currentDate: Date = Date() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.updateDates()
                self.fetchItems(for: self.currentDate)
            }
        }
    }
    
    var dataChanged: (() -> Void)?
    
    var allItems: [TeenStarFemmina] = []
    var dates: [Date] = []
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let itemWidth = width / 5
        return .init(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
        let date = self.dates[indexPath.row]
        let day = Calendar.current.component(.day, from: date)
        cell.dayLabel.text = String(day)
        cell.backgroundColor = .red
        cell.layer.borderWidth = 1
        cell.layer.borderColor = Theme.current.backgroundColor.cgColor
        return cell
    }
    
    func fetchItems(for date: Date) {
        let agent = TSFAgent()
        self.allItems = agent.fetchItems(using: date)
        dataChanged?()
    }
    
    func set(month: Int?, year: Int?) {
        if let month = month {
            self.selectedMonth = month
        }
        
        if let year = year {
            self.selectedYear = year
        }
        
    }
    
    func setUp() {
        let calendar = Calendar.current
        let date = Date()
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        selectedMonth = month
        selectedYear = year
    }
    
    func updateDates() {
        let agent = TSFAgent()
        self.dates = agent.getMonthRange(from: currentDate).map { $0 }
    }
    
    func refresh() {
        self.fetchItems(for: currentDate)
    }
    
}
