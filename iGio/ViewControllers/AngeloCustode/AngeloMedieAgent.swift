//
//  AngeloMedieAgent.swift
//  iGio
//
//  Created by Daniel Bazzani on 03/01/21.
//  Copyright © 2021 Dani Tox. All rights reserved.
//

import Foundation

struct AngeloMedieRisposteFile: Codable {
    var risposte: [String: Int] = [:]
    
    static func get() -> AngeloMedieRisposteFile {
        let url = FileManager.angeloDirectory.appendingPathComponent("angelo_medie_risposte.json")
        
        guard let data = try? Data(contentsOf: url) else { return AngeloMedieRisposteFile() }
        guard let obj = try? JSONDecoder().decode(AngeloMedieRisposteFile.self, from: data) else { return AngeloMedieRisposteFile() }
        return obj
    }
    
    func save() {
        let url = FileManager.angeloDirectory.appendingPathComponent("angelo_medie_risposte.json")
        guard let data = try? JSONEncoder().encode(self) else { return }
        try? data.write(to: url)
    }
}

@available(iOS 13, *)
class AngeloMedieAgent: ObservableObject {
    
    @Published var risposteFile: AngeloMedieRisposteFile
    
    init() {
        risposteFile = AngeloMedieRisposteFile.get()
    }
    
    func getValue(forKey key: String) -> Int {
        return risposteFile.risposte[key] ?? 0
    }
    
    func set(value: Int, forKey: String) {
        risposteFile.risposte[forKey] = value
    }
    
    func save() {
        risposteFile.save()
    }
    
}
