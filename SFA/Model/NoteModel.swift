//
//  NoteModel.swift
//  SFA
//
//  Created by Dani Tox on 27/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation
import CoreData

class NoteModel {
    
    var persistentContainer : NSPersistentContainer
    var errorHandler : ((String) -> Void)?
    
    private var notesStorage : [Date: [Nota]] = [:]
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    @available(*, deprecated)
    func fetchNotes() -> [Nota] {
        let request : NSFetchRequest<Nota> = Nota.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        let context = persistentContainer.viewContext
        var notes : [Nota] = []
        do {
            notes = try context.fetch(request)
            self.invalidateStorage()
        } catch {
            errorHandler?("\(error)")
        }
        
        return notes
    }
    
    //this returns today's note if exist, otherwise returns a new note with date setted as today
    //this shouldn't be called directly. Call safelyGetNoteToEdit instead
    //UPDATE: 09/01/19 - questa funzione non serve più ed è ora deprecata
    @available(*, deprecated)
    private func getNoteToEdit() throws -> Nota {
        let request : NSFetchRequest<Nota> = Nota.fetchRequest()
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        let dateFrom = calendar.startOfDay(for: Date())
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        if dateTo == nil {
            throw ToxException.noteRelated("Errore mentre esguivo qualche controllo delle date. Riprova a creare la nota domani (dalle 00:00 in poi)")
        }
        
        let fromPredicate = NSPredicate(format: "date > %@", dateFrom as NSDate)
        let toPredicate = NSPredicate(format: "date < %@", dateTo! as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        request.predicate = datePredicate
    
        
        let context = persistentContainer.viewContext
        var notes : [Nota] = []
        do {
            notes = try context.fetch(request)
        } catch {
            throw error
        }
        if notes.count == 0 {
            let newNote = Nota(context: persistentContainer.viewContext)
            newNote.date = Date()
            newNote.id = getUniqueID()
            return newNote
        } else if notes.count == 1 {
            return notes.first!
        } else {
            throw ToxException.noteRelated("Ci sono più note con la stessa data!!!")
        }
    }
    
    @available(*, deprecated)
    public func safelyGetNoteToEdit() -> Nota? {
        var nota: Nota!
        do {
            nota = try getNoteToEdit()
            return nota
        } catch {
            self.errorHandler?("\(error)")
        }
        return nil
    }
    
    private func isUniqueID(_ id: Int32) -> Bool {
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Nota> = Nota.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", id)
        request.predicate = predicate
        
        let notes = try? context.fetch(request)
        guard let realNotes = notes else {
            return true
        }
        if realNotes.count > 0 {
            return false
        } else {
            return true
        }
    }
    
    public func getUniqueID() -> Int32 {
        var randomID : Int32
        repeat {
            randomID = Int32.random(in: 0..<INT32_MAX)
        } while isUniqueID(randomID) != true
        
        return randomID
    }
    
    public func createNewNote() -> Nota {
        let note = Nota(context: persistentContainer.viewContext)
        note.date = Date()
        note.id = self.getUniqueID()
        self.invalidateStorage()
        return note
    }
    
    public func getAllDates() -> [Date] {
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Nota> = Nota.fetchRequest()
        var dates = Set<Date>()
        do {
            let array = try context.fetch(request)
            array.forEach { (note) in
                if let date = note.date {
                    var calendar = Calendar.current
                    calendar.timeZone = NSTimeZone.local
                    dates.insert(calendar.startOfDay(for: date))
                }
            }
        } catch {
            print(error)
        }
        self.invalidateStorage()
        let array = Array(dates)
        return array.sorted(by: {$0 > $1})
    }
 
    //N.B. Questa funzione la prima volta che viene chiamata, ottiene i risultati da CoreData e li salva
    // nella variabile 'notesStorage' di questo oggetto usando la data passata come param.
    //In questo modo se viene chiamata di nuovo con la stessa Date non deve ritornare nel Database
    //Lo storage viene invalidato ad ogni FULL fetch delle note dal database
    public func getNotes(for date: Date) -> [Nota] {
        if let notePerDataInStorage = notesStorage[date.startOfDay], !notePerDataInStorage.isEmpty {
            print("Dates ottenute dallo storage")
            return notePerDataInStorage
        }
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<Nota> = Nota.fetchRequest()
    
        var calendar = Calendar.current
        calendar.locale = NSLocale.current
        
        let dateFrom = date.startOfDay
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        if dateTo == nil {
            self.errorHandler?("Errore mentre esguivo qualche controllo delle date. Riprova a creare la nota domani (dalle 00:00 in poi)")
            return []
        }
        
        let fromPredicate = NSPredicate(format: "date > %@", dateFrom as NSDate)
        let toPredicate = NSPredicate(format: "date < %@", dateTo! as NSDate)
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        request.predicate = datePredicate
        
        var notes : [Nota] = []
        do {
            notes = try context.fetch(request)
            notes.sort(by: { $0.date! > $1.date! })
            self.notesStorage[dateFrom] = notes
        } catch {
            print(error)
        }
        print("Dates ottenute dal Database")
        return notes
    }
    
    //funzione che cancella le noteStorage e causa la ricerca dal database invece che dallo storage
    private func invalidateStorage() {
        print("Storage invalidato")
        self.notesStorage.removeAll()
    }
    
}
