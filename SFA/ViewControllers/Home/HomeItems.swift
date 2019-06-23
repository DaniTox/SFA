//
//  HomeCells.swift
//  MGS
//
//  Created by Dani Tox on 09/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

struct HomeItem {
    var idNumber: Int
    var name: String
    var image: UIImage?
    var color: UIColor
    var allowedAge: [ScuolaType]
    var allowedGenders: [UserGender]
}


let allHomeItems: [HomeItem] = [
    HomeItem(idNumber: 0, name: "Diario personale", image: #imageLiteral(resourceName: "diary"), color: .blue, allowedAge: ScuolaType.allCases, allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 1, name: "TeenSTAR", image: #imageLiteral(resourceName: "star"), color: .purple, allowedAge: ScuolaType.allCases, allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 2, name: "GioProNet", image: #imageLiteral(resourceName: "weightscale"), color: .red, allowedAge: ScuolaType.allCases, allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 3, name: "Agenda dell'allegria e della santità", image: #imageLiteral(resourceName: "airplane"), color: .darkGreen, allowedAge: [.medie], allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 4, name: "Il mio percorso formativo", image: #imageLiteral(resourceName: "search"), color: .orange, allowedAge: [.biennio, .triennio], allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 5, name: "Il progetto delle 3S", image: #imageLiteral(resourceName: "airplane"), color: .darkGreen, allowedAge: [.biennio], allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 6, name: "Regola di Vita", image: #imageLiteral(resourceName: "airplane"), color: .darkGreen, allowedAge: [.triennio], allowedGenders: UserGender.allCases) //✅
]

