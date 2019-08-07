//
//  OrderedFlowCoordinator.swift
//  SFA
//
//  Created by Dani Tox on 16/02/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

protocol OrderedFlowCoordinator : Coordinator {
    var currentShowingControllerIndex : Int { get set }
    var controllers: [OrderedFlowController] { get set }
    func next(from vc: UIViewController)
}


protocol OrderedFlowController where Self: UIViewController {
    var orderingCoordinator : OrderedFlowCoordinator? { get set }
    
    var showCurrentValue: Bool { get set }
}
