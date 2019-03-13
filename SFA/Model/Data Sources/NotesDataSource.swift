//
//  NotesDataSource.swift
//  SFA
//
//  Created by Dani Tox on 10/03/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import UIKit
import RealmSwift

class NotesDataSource : NSObject, UITableViewDataSource {
    
    private var noteModel : NoteModel = NoteModel()
    
    public var errorHandler : ((Error) -> Void)? {
        didSet {
            noteModel.errorHandler = errorHandler
        }
    }
    public var dataLoaded : (() -> Void)?
    
    func updateData() {
        noteModel.fullFetch()
        dataLoaded?()
    }
    
    func getNewNote() -> Note {
        let newNote = noteModel.createNewNote()
//        if let storageOfToday = noteModel.notesCache.first(where: { $0.date == Date().startOfDay }) {
//            storageOfToday.notes.append(newNote)
//        } else {
//            let newStorage = NoteStorage(date: Date().startOfDay, notes: [newNote])
//            noteModel.notesCache.insert(newStorage, at: 0)
//        }
        return newNote
    }
    
    func getNoteAt(indexPath: IndexPath) -> Note {
        return noteModel.notesCache[indexPath.section].notes[indexPath.row]
    }
    
    func remove(note: Note) {
        noteModel.remove(note: note)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return noteModel.notesCache.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let storage = noteModel.notesCache[section]
        return storage.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BoldCell
        let note = noteModel.notesCache[indexPath.section].notes[indexPath.row]
        
        let attributedBody : NSAttributedString = note.getBody()
        let stringValue : String = attributedBody.string
        
        let count = stringValue.wordsCount
        
        cell.rightBottomLabel.text = "\(count) parole"
        cell.mainLabel.text = note.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateFocued = noteModel.notesCache[section].date
        if dateFocued.isToday() {
            return "Oggi"
        } else if dateFocued.isYesterday() {
            return "Ieri"
        } else {
            return "\(dateFocued.dayOfWeek()) - \(dateFocued.stringValue)"
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = self.getNoteAt(indexPath: indexPath)
            let noteStorageCount = self.noteModel.notesCache[indexPath.section].notes.count
            self.remove(note: note)
            
            if (noteStorageCount - 1) == 0 {
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            dataLoaded?()
        }
    }
    
}
