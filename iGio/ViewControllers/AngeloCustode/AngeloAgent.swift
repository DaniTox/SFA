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
    
    var risposteChangesObserver: AnyCancellable?
    
    init() {
        domandeFile = AngeloDomandeFile.get()
        risposteFile = AngeloRisposteFile.get() ?? AngeloRisposteFile()
        
        risposteChangesObserver = risposteFile.objectWillChange.sink {
            self.objectWillChange.send()
        }
    }
    
    func stopObservingChanges() {
        self.risposteChangesObserver?.cancel()
        self.risposteChangesObserver = nil
    }
}
