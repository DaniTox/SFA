//
//  FileManager+Extension.swift
//  iGio
//
//  Created by Daniel Bazzani on 20/12/20.
//  Copyright © 2020 Dani Tox. All rights reserved.
//

import Foundation

extension FileManager {
    static func getVerificaDirectory(for type: ScuolaType) -> URL {
        let model = CompagniaAgent()
        let fileName = "risposte_\(model.getFileName(for: type)).json"
        
        let urls = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        let appURL = urls.first!.appendingPathComponent("Verifica")
        
        try? FileManager.default.createDirectory(at: appURL, withIntermediateDirectories: true, attributes: nil)
        
        return appURL.appendingPathComponent(fileName)
    }
    
    static var angeloDirectory: URL {
        let urls = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        let appURL = urls.first!.appendingPathComponent("Angelo")
        
        try? FileManager.default.createDirectory(at: appURL, withIntermediateDirectories: true, attributes: nil)
        
        return appURL
    }
}
