//
//  InfoVC.swift
//  MGS
//
//  Created by Dani Tox on 04/05/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit

class InfoVC : UIViewController, HasCustomView {
    typealias CustomView = InfoView
    override func loadView() {
        self.view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Info"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.textView.attributedText = getTextFromFile()
    }
    
    func getTextFromFile() -> NSAttributedString {
        guard let fileUrl = Bundle.main.url(forResource: "welcomeText", withExtension: "rtf") else {
            fatalError()
        }
        guard let data = try? Data(contentsOf: fileUrl) else { fatalError() }
        let options : [ NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType : NSAttributedString.DocumentType.rtf]
        
        guard let str = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) else { fatalError() }
        
        let range = NSRange(location: 0, length: str.length - 1)
        str.addAttribute(.foregroundColor, value: Theme.current.textColor, range: range)
        return str
    }
}
