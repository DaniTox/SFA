//
//  TaskButton.swift
//  MGS
//
//  Created by Dani Tox on 05/05/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class TaskButton: UIButton {
    var task: GioProNetTask
    
    init(imageNamed: String, task: GioProNetTask) {
        self.task = task
        super.init(frame: .zero)
//
//        guard let path = Bundle.main.url(forResource: imageNamed, withExtension: "png") else { fatalError() }
//        guard let image = UIImage(contentsOfFile: path.path) else { fatalError() }
//
//
//        self.setImage(image, for: .normal)
        
        //da usare mentre non si hanno le immagini
        
        self.setTitle(imageNamed, for: .normal)
        self.setTitleColor(Theme.current.textColor, for: .normal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
