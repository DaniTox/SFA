//
//  GenderBox.swift
//  SFA
//
//  Created by Dani Tox on 16/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class GenderBox : UIBox {
    
    var gender: UserGender
    
    init(gender: UserGender, frame: CGRect) {
        self.gender = gender
        super.init(frame: frame)
        
        if gender == .boy {
            self.backgroundColor = UIColor.blue.darker()
            self.mainLabel.text = "Maschio"
        } else {
            self.backgroundColor = UIColor.purple.lighter()
            self.mainLabel.text = "Femmina"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
