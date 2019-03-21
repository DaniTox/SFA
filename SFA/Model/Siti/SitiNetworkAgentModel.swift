//
//  SitiModel.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

class SitiNetworkAgent : NetworkAgent<SitiNetworkResponse> {
    
    func getWebsites(type: WebsiteType, completion: (([SitoObject]) -> Void)? = nil) {
        if type == .materiali {
            let request = SitiMaterialiRequest()
            self.executeNetworkRequest(with: request) { (response) in
                completion?(response.siti)
            }
        } else {
            let request = SitiPreghiereRequest()
            self.executeNetworkRequest(with: request) { (response) in
                completion?(response.siti)
            }
        }
        
        
    }

}

enum WebsiteType {
    case materiali
    case preghiere
}
