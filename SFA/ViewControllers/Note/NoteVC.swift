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
        let cview = CustomView()
        cview.controller = self
        view = cview
    }
    var note : Nota!
    var sizeAlert : SizeSliderAlert?
    var colorAlert : ColorSliderAlert?
    var isWorkingVC : Bool = true
    
    init(nota: Nota?) {
        if nota == nil {
            self.isWorkingVC = false
            self.note = nil
        } else {
            self.note = nota!
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        
        rootView.bottomBar.sizeButton.addTarget(self, action: #selector(showSizeAlert), for: .touchUpInside)
        rootView.bottomBar.colorButton.addTarget(self, action: #selector(showColorAlert), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initTextView()
    }
    
    private func initTextView() {
        if let note = self.note {
            let bar = UIToolbar()
            let dimensionButton = UIBarButtonItem(title: "Dimensione", style: .plain, target: self, action: #selector(showSizeAlert))
            let colorButton = UIBarButtonItem(title: "Colore", style: .plain, target: self, action: #selector(showColorAlert))
            bar.items = [dimensionButton, colorButton]
            bar.sizeToFit()
            rootView.textView.inputAccessoryView = bar
            rootView.textView.attributedText = (note.body as? NSAttributedString)
        } else {
            rootView.textView.isEditable = false
            rootView.bottomBar.alpha = 0
        }
        setTitle()
    }
    
    private func setTitle() {
        if self.note == nil {
            self.title = "Nessuna nota selezionata"
            return
        }
        guard let noteDate = self.note.date else { return }
        if noteDate.isToday() { self.title = "Oggi" }
        else if noteDate.isYesterday() { self.title = "Ieri" }
        else { self.title = noteDate.stringValue }
    }
    
    private func saveNote() {
        guard self.isWorkingVC == true else { return }
        var title = rootView.textView.attributedText.string.firstLine
        if title.isEmpty { title = "Nota vuota" }
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
        if self.isWorkingVC {
            saveNote()
        } else {
            removeNote()
        }
    }
    
    private func removeNote() {
        guard let note = self.note else { return }
        note.managedObjectContext?.delete(note)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let alert = self.sizeAlert {
            alert.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
            alert.centerYAnchor.constraint(equalTo: rootView.centerYAnchor).isActive = true
            alert.heightAnchor.constraint(equalTo: rootView.heightAnchor, multiplier: 0.4).isActive = true
            alert.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 0.7).isActive = true
            alert.setNeedsLayout()
        }
        if let alert = self.colorAlert {
            alert.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
            alert.centerYAnchor.constraint(equalTo: rootView.centerYAnchor).isActive = true
            alert.heightAnchor.constraint(equalTo: rootView.heightAnchor, multiplier: 0.4).isActive = true
            alert.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 0.7).isActive = true
            alert.setNeedsLayout()
        }
    }
    
    @objc private func showColorAlert() {
        if self.colorAlert != nil || self.sizeAlert != nil { return }
        self.colorAlert = ColorSliderAlert(frame: .zero)
        colorAlert?.layer.masksToBounds = true
        colorAlert?.layer.cornerRadius = 10
        self.colorAlert?.translatesAutoresizingMaskIntoConstraints = false
        colorAlert?.completionHandler = { [weak self] (newColor) in
            DispatchQueue.main.async {
                self?.dismissColorAlert()
            }
        }
        colorAlert?.newValueHandler = { [weak self] (newValue) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                let textView = self.rootView.textView
                let selectedRange = textView.selectedRange
                
                if selectedRange.length > 0 {
                    let myAttribute = [NSAttributedString.Key.foregroundColor: newValue]
                    textView.textStorage.addAttributes(myAttribute, range: selectedRange)
                } else {
                    textView.typingAttributes[NSAttributedString.Key.foregroundColor] = newValue
                }
            }
        }
        rootView.addSubview(self.colorAlert!)
        rootView.setNeedsLayout()
        
        self.colorAlert?.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.colorAlert?.alpha = 1
        }
    }
    
    private func dismissColorAlert() {
        UIView.animate(withDuration: 0.3, animations: {
            self.colorAlert?.alpha = 0
        }) { completed in
            if completed != true {
                return
            }
            self.colorAlert?.removeFromSuperview()
            self.colorAlert = nil
        }
    }
    
    @objc private func showSizeAlert() {
        if self.colorAlert != nil || self.sizeAlert != nil { return }
        let initialValue = Int(rootView.textView.font?.pointSize ?? 19)
        self.sizeAlert = SizeSliderAlert(frame: .zero, initialValue: initialValue)
        sizeAlert?.layer.masksToBounds = true
        sizeAlert?.layer.cornerRadius = 10
        self.sizeAlert?.translatesAutoresizingMaskIntoConstraints = false   
        sizeAlert?.completionHandler = { [weak self] (newSize) in
            DispatchQueue.main.async {
                self?.dismissSizeAlert()
            }
        }
        sizeAlert?.newValueHandler = { [weak self] (newSize) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                let textView = self.rootView.textView
                let selectedRange = textView.selectedRange
                let currentFont = textView.font ?? UIFont.preferredFont(forTextStyle: .body).withSize(19)
                let newSizeFloat = CGFloat(newSize)
                
                if selectedRange.length > 0 {
                    let myAttributes = [NSAttributedString.Key.font: currentFont.withSize(newSizeFloat)]
                    textView.textStorage.addAttributes(myAttributes, range: selectedRange)
                } else {
                    textView.typingAttributes[NSAttributedString.Key.font] = currentFont.withSize(newSizeFloat)
                }
            }
        }
        rootView.addSubview(sizeAlert!)
        rootView.setNeedsLayout()
        self.sizeAlert?.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.sizeAlert?.alpha = 1
        }
    }
    
    private func dismissSizeAlert() {
        UIView.animate(withDuration: 0.3, animations: {
            self.sizeAlert?.alpha = 0
        }) { (completed) in
            if completed != true { return }
            self.sizeAlert?.removeFromSuperview()
            self.sizeAlert = nil
        }
    }
}
