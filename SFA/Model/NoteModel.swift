//
//  NoteModel.swift
//  SFA
//
//  Created by Dani Tox on 27/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation
import CoreData
import RealmSwift

class NoteModel {
    
    var errorHandler : ((Error) -> Void)?
    
    public var notesCache : [NoteStorage] = []
    
    public func createNewNote() -> Note {
        let note = Note()
        note.date = Date()
        return note
    }
    
    public func fullFetch() {
        let realm = try! Realm()
        let notes = Array(realm.objects(Note.self))
        
        notesCache = []
        
        let allDates = Array(Set<Date>(notes.compactMap({ $0.date.startOfDay })).sorted(by: {$0 > $1}))
        allDates.forEach({ (date) in
            let notes = notes.filter({ $0.date.startOfDay == date })
            let newStorage = NoteStorage(date: date, notes: notes)
            notesCache.append(newStorage)
        })
    }
    
    func remove(note: Note) {
        let storage = notesCache.first { $0.notes.contains(note) }
        storage?.notes.removeAll(where: { $0 == note })
        if storage?.notes.count ?? 0 <= 0 {
            notesCache.removeAll(where: { $0 == storage })
        }

        let realm = try! Realm()
        try? realm.write {
            realm.delete(note)
        }
    }
    
    //funzione che cancella le noteStorage e causa la ricerca dal database invece che dallo storage
    private func invalidateStorage() {
        print("Storage invalidato")
        self.notesCache.removeAll()
    }
    
}
