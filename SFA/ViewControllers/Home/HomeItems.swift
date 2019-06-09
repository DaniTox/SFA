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
    var allowedAge: [ScuolaType]
    var allowedGenders: [UserGender]
}

let allItems: [HomeItem] = [
    HomeItem(idNumber: 0, name: "Diario personale", image: nil, allowedAge: ScuolaType.allCases, allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 1, name: "TeenSTAR", image: nil, allowedAge: ScuolaType.allCases, allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 2, name: "GioProNet", image: nil, allowedAge: ScuolaType.allCases, allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 3, name: "Agenda dell'allegria e della santità", image: nil, allowedAge: [.medie], allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 4, name: "Il mio percorso formativo", image: nil, allowedAge: [.biennio, .triennio], allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 5, name: "Il progetto delle 3S", image: nil, allowedAge: [.biennio], allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 6, name: "Regola di Vita", image: nil, allowedAge: [.triennio], allowedGenders: UserGender.allCases) //✅
]

