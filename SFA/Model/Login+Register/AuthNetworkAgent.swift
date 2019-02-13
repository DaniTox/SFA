//
//  AuthNetworkAgent.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

class AuthNetworkAgent : NetworkAgent<AuthNetworkResponse> {
    
    func login(email: String, password: String, completion: (() -> Void)? = nil) {
        let usr = User()
        usr.email = email
        
        let passwordAttempted = password
        
        let request = LoginNetworkRequest()
        request.user = usr
        request.password = passwordAttempted
        
        executeNetworkRequest(with: request) { [weak self] (response) in
            guard let user = response.user else {
                self?.errorHandler?("C'è stato un errore durante la fase di login. Riprova più tardi (Codice errore: -4)")
                return
            }
            userLogged = user
            completion?()
        }
    }
    
    func register(user: User, completion: (()->Void)? = nil) {
        let request = RegisterNetworkRequest()
        request.credentials = user
        
        executeNetworkRequest(with: request) { [weak self] (response) in
            guard let user = response.user else {
                self?.errorHandler?("C'è stato un errore durante la fase di registrazione. Riprova più tardi (Codice errore: -5)")
                return
            }
            userLogged = user
            completion?()
        }
        
    }
    
}
