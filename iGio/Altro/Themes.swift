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
    var cellSubtitleColor : UIColor { get }
    var cellTitleColor : UIColor { get }
    var tableHeaderTextColor: UIColor { get }
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
    var tableViewBackground: UIColor = UIColor.lightGray.lighter(by: 20)!
    var backgroundColor: UIColor = UIColor.lightGray.lighter()!
    var shadowColor: UIColor = UIColor.gray
    var textColor : UIColor = UIColor.black
    var cellSubtitleColor: UIColor = UIColor.gray
    var cellTitleColor: UIColor = UIColor.blue
    var tableHeaderTextColor: UIColor = UIColor(named: "lightBlue")!
}

class DarkTheme : ThemeProtocol {
    var tableViewBackground: UIColor = UIColor.black.lighter(by: 17)!
    var controllerBackground: UIColor = UIColor.black.lighter(by: 15)!
    var backgroundColor: UIColor = UIColor.black.lighter(by: 5)!
    var shadowColor: UIColor = UIColor.darkGray.darker()!
    var textColor: UIColor = UIColor.white
    var cellSubtitleColor: UIColor = UIColor.gray
    var cellTitleColor: UIColor = UIColor.white
    var tableHeaderTextColor: UIColor = UIColor(named: "lightBlue")!
}

@available(iOS 13, *)
class DynamicTheme: ThemeProtocol {
    var tableViewBackground: UIColor = UIColor.systemBackground
    var controllerBackground: UIColor = UIColor.systemBackground
    var backgroundColor: UIColor = UIColor(named: "cellColor")!
    var shadowColor: UIColor = UIColor.clear
    var textColor: UIColor = UIColor.label
    var cellSubtitleColor: UIColor = UIColor.secondaryLabel
    var cellTitleColor: UIColor = UIColor.label
    var tableHeaderTextColor: UIColor = UIColor(named: "lightBlue")!
}
