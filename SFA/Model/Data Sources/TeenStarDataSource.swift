//
//  TeenStarDataSource.swift
//  SFA
//
//  Created by Dani Tox on 15/03/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class TeenStarDataSource : NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

let BASIC_CELL_ID = "cell"
let EMOZIONE_CELL_ID = "emozioneCell"
let CICLO_CELL_ID = "ciclocell"

let BASIC_ROW_HEIGHT : CGFloat = 75
let EMOZIONE_ROW_HEIGHT : CGFloat = 200
let CICLO_ROW_HEIGHT : CGFloat = 500 //350

let TSBOY_SECTIONS = 4
let TSGIRL_SECTIONS = 5

func GET_INDEX(_ index: Int) -> Int { return index - 1 }
