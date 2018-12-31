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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NoteCell else {
            return UITableViewCell()
        }
        let note = notes[indexPath.row]
        if note.date?.isToday() ?? false {
            cell.noteDateLabel.text = "Oggi"
        } else if note.date?.isYesterday() ?? false {
            cell.noteDateLabel.text = "Ieri"
        } else {
            cell.noteDateLabel.text = note.date?.stringValue
        }
        
        cell.noteTitleLabel.text = note.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        let vc = NoteVC(nota: note)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
