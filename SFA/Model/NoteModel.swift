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
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
    }
    
    func fetchNotes() -> [Nota] {
        let request : NSFetchRequest<Nota> = Nota.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        let context = persistentContainer.viewContext
        var notes : [Nota] = []
        do {
            notes = try context.fetch(request)
        } catch {
            errorHandler?("\(error)")
        }
        
        return notes
    }
    
    //this returns today's note if exist, otherwise returns a new note with date setted as today
    //this shouldn't be called directly. Call safelyGetNoteToEdit instead
    private func getNoteToEdit() throws -> Nota {
        let request : NSFetchRequest<Nota> = Nota.fetchRequest()
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        let dateFrom = calendar.startOfDay(for: Date())
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        if dateTo == nil {
            throw ToxError.noteRelated("Errore mentre esguivo qualche controllo delle date. Riprova a creare la nota domani (dalle 00:00 in poi)")
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
            let newNote = Nota(context: persistentContainer.newBackgroundContext())
            return newNote
        } else if notes.count == 1 {
            return notes.first!
        } else {
            throw ToxError.noteRelated("Ci sono più note con la stessa data!!!")
        }
    }
    
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
    
}
