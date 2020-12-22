//
//  AngeloAgent.swift
//  iGio
//
//  Created by Daniel Bazzani on 21/12/20.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13, *)
class AngeloAgent: ObservableObject {
    
    var domandeFile: AngeloDomandeFile
    var risposteFile: AngeloRisposteFile
    
    var preghiera: String = ""
    
    var risposteChangesObserver: AnyCancellable?
    
    init() {
        domandeFile = AngeloDomandeFile.get()
        risposteFile = AngeloRisposteFile.get() ?? AngeloRisposteFile()
        
        let preghieraUrl = Bundle.main.url(forResource: "preghiera_angelo_custode", withExtension: "txt")!
        if let data = try? Data(contentsOf: preghieraUrl) {
            preghiera = String(data: data, encoding: .utf8) ?? ""
        }
        
        
        risposteChangesObserver = risposteFile.objectWillChange.sink {
            self.objectWillChange.send()
        }
    }
    
    func save() {
        risposteFile.save()
    }
    
    func stopObservingChanges() {
        self.risposteChangesObserver?.cancel()
        self.risposteChangesObserver = nil
    }
}
