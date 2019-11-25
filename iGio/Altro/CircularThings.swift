//
//  CircularThings.swift
//  SFA
//
//  Created by Dani Tox on 21/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

@IBDesignable
class CircularView: UIView {
    
    @IBInspectable
    var cornerRadius : CGFloat {
        get {
            return self.layer.cornerRadius
        } set {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = newValue
        }
    }
}
