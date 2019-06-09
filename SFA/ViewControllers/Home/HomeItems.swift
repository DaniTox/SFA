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
    HomeItem(idNumber: 0, name: "Diario personale", image: nil, color: .blue, allowedAge: ScuolaType.allCases, allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 1, name: "TeenSTAR", image: nil, color: .purple, allowedAge: ScuolaType.allCases, allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 2, name: "GioProNet", image: nil, color: .red, allowedAge: ScuolaType.allCases, allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 3, name: "Agenda dell'allegria e della santità", image: nil, color: .green, allowedAge: [.medie], allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 4, name: "Il mio percorso formativo", image: nil, color: .orange, allowedAge: [.biennio, .triennio], allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 5, name: "Il progetto delle 3S", image: nil, color: .green, allowedAge: [.biennio], allowedGenders: UserGender.allCases), //✅
    HomeItem(idNumber: 6, name: "Regola di Vita", image: nil, color: .green, allowedAge: [.triennio], allowedGenders: UserGender.allCases) //✅
]

