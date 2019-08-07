//
//  Protocolli.swift
//  SFA
//
//  Created by Dani Tox on 14/11/2018.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

protocol HasCustomView {
    associatedtype CustomView : UIView
}

extension HasCustomView where Self: UIViewController {
    internal var rootView : CustomView {
        guard let rootView = view as? CustomView else {
            fatalError("Expected view to be of type \(CustomView.self) but got \(type(of: view)) instead")
        }
        return rootView
    }
}
