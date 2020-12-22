//
//  AngeloAgent.swift
//  iGio
//
//  Created by Daniel Bazzani on 20/12/20.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import Foundation

struct AngeloDomandeFile: Codable {
    var domande: [Item]
    var parole: [Item]
    
    struct Item: Codable {
        var str: String
        var id: UUID
    }
    
    //force-unwrapped perchè sappiamo che funzionarà sicuramente. Solo in debug potrebbe non funzionare mentre cambiamo il nome del file o la struttura del json
    static func get() -> AngeloDomandeFile {
        let url = Bundle.main.url(forResource: "angelo_custode", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(AngeloDomandeFile.self, from: data)
    }
    
}

@available(iOS 13, *)
class AngeloRisposteFile: Codable, ObservableObject {
    private(set) var risposte: [UUID: String] = [:]
    var paroleChecked: [UUID: Bool] = [:]
    var preghieraParola: String = ""
    
    func set(parolaChecked: Bool, forParolaID parolaID: UUID) {
        self.paroleChecked[parolaID] = parolaChecked
        objectWillChange.send()
    }
    
    func set(risposta: String, forID domandaID: UUID) {
        self.risposte[domandaID] = risposta
        objectWillChange.send()
    }
    
    static func get() -> AngeloRisposteFile? {
        let fileName = "risposte_angelo.json"
        let url = FileManager.angeloDirectory.appendingPathComponent(fileName)
        
        guard let data = try? Data(contentsOf: url) else { return AngeloRisposteFile() }
        guard let risposteFile = try? JSONDecoder().decode(AngeloRisposteFile.self, from: data) else { return AngeloRisposteFile() }
        return risposteFile
    }

    
    func save() {
        let fileName = "risposte_angelo.json"
        let url = FileManager.angeloDirectory.appendingPathComponent(fileName)
        
        guard let data = try? JSONEncoder().encode(self) else { return }
        try? data.write(to: url)
    }
}
