//
//  NoteVC.swift
//  SFA
//
//  Created by Dani Tox on 11/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class NoteVC: UIViewController, HasCustomView {
    typealias CustomView = NoteView
    override func loadView() {
        super.loadView()
        let cview = CustomView()
        cview.controller = self
        view = cview
    }
    
    var note : Note
    
    var sizeAlert : SizeSliderAlert?
    var colorAlert : ColorSliderAlert?
    
    init(nota: Note) {
        self.note = nota
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateTheme() {
        rootView.backgroundColor = Theme.current.backgroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        
        NotificationCenter.default.addObserver(forName: .updateTheme, object: nil, queue: .main) { (notification) in
            self.updateTheme()
        }
        
        rootView.bottomBar.sizeButton.addTarget(self, action: #selector(showSizeAlert), for: .touchUpInside)
        rootView.bottomBar.colorButton.addTarget(self, action: #selector(showColorAlert), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initTextView()
    }
    
    private func initTextView() {
        let bar = UIToolbar()
        let dimensionButton = UIBarButtonItem(title: "Dimensione", style: .plain, target: self, action: #selector(showSizeAlert))
        let colorButton = UIBarButtonItem(title: "Colore", style: .plain, target: self, action: #selector(showColorAlert))
        bar.items = [dimensionButton, colorButton]
        bar.sizeToFit()
        rootView.textView.inputAccessoryView = bar
        rootView.textView.attributedText = note.getBody()
        setTitle()
        
        if rootView.textView.text.isEmpty {
            rootView.textView.textColor = UIColor(named: "lightBlue")
        }
    }
    
    private func setTitle() {
        let noteDate = self.note.date
        if noteDate.isToday() { self.title = "Oggi" }
        else if noteDate.isYesterday() { self.title = "Ieri" }
        else { self.title = noteDate.stringValue }
    }
    
    private func saveNote() {
        let currentAttributedText = rootView.textView.attributedText
        if currentAttributedText?.string.isEmpty ?? false {
            removeNote()
            return
        }
        
        var title = rootView.textView.attributedText.string.firstLine
        if title.isEmpty { title = "Nota vuota" }
        
        let realm = try! Realm()
        try? realm.write {
            note.title = title
            note.setBody(attributedString: rootView.textView.attributedText)
            realm.add(note, update: .modified)
        }
        
        if title == "developer=true" {
            shouldDisplayDeveloperName = true
        } else if title == "developer=false" {
            shouldDisplayDeveloperName = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveNote()
    }
    
    private func removeNote() {
        let realm = try! Realm()
        
        if let savedNote = realm.objects(Note.self).filter(NSPredicate(format: "id == %@", note.id)).first {
            try? realm.write {
                realm.delete(savedNote)
            }
        }
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
        self.rootView.textView.resignFirstResponder()
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
        self.rootView.textView.resignFirstResponder()
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
