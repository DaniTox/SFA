//
//  Themes.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    var backgroundColor: UIColor { get }
    var shadowColor : UIColor { get }
    var textColor : UIColor { get }
    var controllerBackground : UIColor { get }
    var tableViewBackground: UIColor { get }
}

class Theme {
    static var current : ThemeProtocol = LightTheme() {
        didSet {
            theme = (Theme.current is LightTheme) ? "light" : "dark"
            NotificationCenter.default.post(name: .updateTheme, object: nil)
        }
    }
}


class LightTheme: ThemeProtocol {
    var controllerBackground: UIColor = UIColor.white
    var tableViewBackground: UIColor = UIColor.lightGray.lighter(by: 10)!
    var backgroundColor: UIColor = UIColor.lightGray.lighter()!
    var shadowColor: UIColor = UIColor.gray
    var textColor : UIColor = UIColor.black
}

class DarkTheme : ThemeProtocol {
    var tableViewBackground: UIColor = UIColor.black.lighter(by: 15)!
    var controllerBackground: UIColor = UIColor.black.lighter(by: 15)!
    var backgroundColor: UIColor = UIColor.black.lighter(by: 5)!
    var shadowColor: UIColor = UIColor.darkGray.darker()!
    var textColor: UIColor = UIColor.white
}
