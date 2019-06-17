//
//  SitiModel.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

class SitiNetworkAgent : NetworkAgent<SitiNetworkResponse> {
    
    func getWebsites(type: SitoCategoria, completion: (([SitoObject], SitoCategoriaObject) -> Void)? = nil) {
        if type == .materiali {
            let request = SitiMaterialiRequest()
            self.executeNetworkRequest(with: request) { (response) in
                completion?(response.siti, response.categoria)
            }
        } else {
            let request = SitiPreghiereRequest()
            self.executeNetworkRequest(with: request) { (response) in
                completion?(response.siti, response.categoria)
            }
        }
    }
}
