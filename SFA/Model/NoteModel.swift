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
    
    public var notesStorage : [NoteStorage] = []
    
    public func createNewNote() -> Note {
        let note = Note()
        note.date = Date()
        self.invalidateStorage()
        return note
    }
    
    public func fullFetch() {
        let realm = try! Realm()
        let notes = Array(realm.objects(Note.self))
        
        notesStorage = []
        
        let allDates = Array(Set<Date>(notes.compactMap({ $0.date.startOfDay })).sorted())
        allDates.forEach({ (date) in
            let notes = notes.filter({ $0.date.startOfDay == date })
            let newStorage = NoteStorage(date: date, notes: notes)
            notesStorage.append(newStorage)
        })
    }
    
//    public func getAllDates() -> [Date] {
//        let realm = try! Realm()
//        let set = Set<Date>(realm.objects(Note.self).compactMap({ $0.date.startOfDay }))
//        return set.map({ $0 }).sorted(by: {$0 > $1})
//    }
 
    //N.B. Questa funzione la prima volta che viene chiamata, ottiene i risultati da CoreData e li salva
    // nella variabile 'notesStorage' di questo oggetto usando la data passata come param.
    //In questo modo se viene chiamata di nuovo con la stessa Date non deve ritornare nel Database
    //Lo storage viene invalidato ad ogni FULL fetch delle note dal database
//    public func getNotes(for date: Date) -> [Note] {
//        if let notePerDataInStorage = notesStorage[date.startOfDay], !notePerDataInStorage.isEmpty {
//            print("Dates ottenute dallo storage")
//            return notePerDataInStorage
//        }
//        var calendar = Calendar.current
//        calendar.locale = NSLocale.current
//
//        let dateFrom = date.startOfDay
//        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
//        if dateTo == nil {
//            self.errorHandler?("Errore mentre esguivo qualche controllo delle date. Riprova a creare la nota domani (dalle 00:00 in poi)")
//            return []
//        }
//
//        let fromPredicate = NSPredicate(format: "date > %@", dateFrom as NSDate)
//        let toPredicate = NSPredicate(format: "date < %@", dateTo! as NSDate)
//        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
//
//        let realm = try! Realm()
//        let notes = realm.objects(Note.self).filter(datePredicate).sorted(by: { $0.date > $1.date })
//        self.notesStorage[dateFrom] = notes
//
//        print("Dates ottenute dal Database")
//        return notes
//    }
    
//    public func getAllNotes() -> [Note] {
//        let realm = try! Realm()
//        return realm.objects(Note.self).map { $0 }
//    }
    
    //funzione che cancella le noteStorage e causa la ricerca dal database invece che dallo storage
    private func invalidateStorage() {
        print("Storage invalidato")
        self.notesStorage.removeAll()
    }
    
}
