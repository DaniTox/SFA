//
//  NoteVC.swift
//  SFA
//
//  Created by Dani Tox on 11/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class NoteVC: UIViewController, HasCustomView {
    typealias CustomView = NoteView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    var note : Nota
    
    init(nota: Nota) {
        self.note = nota
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.textView.attributedText = (note.body as? NSAttributedString)
    }
    
    private func saveNote() {
        var title = rootView.textView.attributedText.string.firstLine
        if title.isEmpty { title = "Nessun titolo" }
        note.title = title
        note.body = rootView.textView.attributedText
        
        let context = note.managedObjectContext
        do {
          try context?.save()
        } catch {
            self.showError(withTitle: "Errore", andMessage: "Errore nel salvataggio in CoreData")
            print("\(error)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveNote()
    }
    
}
