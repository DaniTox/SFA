//
//  NoteListVC.swift
//  SFA
//
//  Created by Dani Tox on 27/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import UIKit

class NoteListVC: UIViewController, HasCustomView {
    typealias CustomView = NoteListView
    override func loadView() {
        super.loadView()
        view = CustomView()
    }
    
    var model : NoteModel!
    //var notes : [Nota] = []
    
    private var notesDates : [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pagine"
        
        let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
        model = NoteModel(container: persistentContainer!)
        model.errorHandler = { [weak self] (errorString) in
            self?.showError(withTitle: "Errore", andMessage: errorString) //already in MainQueue
        }
        
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.register(NoteCell.self, forCellReuseIdentifier: "cell")
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        navigationItem.setRightBarButton(addButton, animated: true)
        
        assert(model != nil, "Non hai settato il model in NoteListVC")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchNotes()
    }
    
    private func fetchNotes() {
        //notes = model.fetchNotes()
        notesDates = model.getAllDates()
        rootView.tableView.reloadData()
    }
    
    @objc private func addButtonPressed() {
        let note = model.createNewNote()
        
        if let splitVC = self.splitViewController {
            let vc = NoteVC(nota: note)
            let nav = UINavigationController(rootViewController: vc)
            splitVC.showDetailViewController(nav, sender: self)
        } else {
            let vc = NoteVC(nota: note)
            navigationController?.pushViewController(vc, animated: true)
        }
        
        fetchNotes()
    }
    
}

extension NoteListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dateFocused = notesDates[section]
        let notesInDate = model.getNotes(for: dateFocused)
        return notesInDate.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return notesDates.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateFocued = notesDates[section]
        if dateFocued.isToday() {
            return "Oggi"
        } else if dateFocued.isYesterday() {
            return "Ieri"
        } else {
            return "\(dateFocued.dayOfWeek()) - \(dateFocued.stringValue)"
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NoteCell else {
            return UITableViewCell()
        }
        let date = notesDates[indexPath.section]
        let note = model.getNotes(for: date)[indexPath.row]
        let attributedBody : NSAttributedString? = note.body as? NSAttributedString
        let stringValue : String? = attributedBody?.string
        let count = stringValue?.wordsCount ?? 0
        cell.noteWordCountLabel.text = "\(count) parole"
        
        cell.noteTitleLabel.text = note.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let date = notesDates[indexPath.section]
        let note = model.getNotes(for: date)[indexPath.row]
        
        if let splitVC = self.splitViewController {
            let vc = NoteVC(nota: note)
            let nav = UINavigationController(rootViewController: vc)
            splitVC.showDetailViewController(nav, sender: self)
        } else {
            let vc = NoteVC(nota: note)
            navigationController?.pushViewController(vc, animated: true)
        }
        fetchNotes()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
    
}
