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
    var notes : [Nota] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
        model = NoteModel(container: persistentContainer!)
        model.errorHandler = { [weak self] (errorString) in
            self?.showError(withTitle: "Errore", andMessage: errorString) //already in MainQueue
        }
        
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        navigationItem.setRightBarButton(addButton, animated: true)
        
        assert(model != nil, "Non hai settato il model in NoteListVC")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchNotes()
    }
    
    private func fetchNotes() {
        notes = model.fetchNotes()
        rootView.tableView.reloadData()
    }
    
    @objc private func addButtonPressed() {
        let note = model.safelyGetNoteToEdit()
        if note == nil {
            self.showError(withTitle: "Errore", andMessage: "C'è stato un errore durante la creazione della nota. Riprova domani")
            return
        }
        let vc = NoteVC(nota: note!)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension NoteListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = "Data: \(note.date ?? Date())"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        let vc = NoteVC(nota: note)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
