//
//  SitiModel.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

class SitiNetworkAgent : NetworkAgent<SitiNetworkResponse> {
    
    func getWebsites(completion: (([SitoCategoriaObject]) -> Void)? = nil) {
        let request = SitiNetworkRequest()
        guard let data = try? JSONEncoder().encode(request) else { fatalError() }
        
        self.executeNetworkRequest(withData: data) { (response) in
            if let sitiArray = response.sites {
                completion?(sitiArray)
            } else {
                self.errorHandler?("Errore nell'ottenere i siti web (-17)")
            }
        }
    }

}
