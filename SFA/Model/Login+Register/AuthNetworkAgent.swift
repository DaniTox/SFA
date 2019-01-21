//
//  AuthNetworkAgent.swift
//  SFA
//
//  Created by Dani Tox on 21/01/19.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import Foundation

class AuthNetworkAgent : NetworkAgent {
    
    func login(email: String, password: String, completion: (() -> Void)? = nil) {
        let credentialsUser = User()
        credentialsUser.email = email
        credentialsUser.password = password
        
        let request = ToxNetworkRequest()
        request.requestType = "login_user"
        request.credentials = credentialsUser
        
        guard let data = try? JSONEncoder().encode(request) else {
            self.errorHandler?("Errore mentre mi stavo preparando per comunicare con il server (Codice errore: -3)")
            return
        }
        executeNetworkRequest(withData: data) { [weak self] (response) in
            guard let user = response.user else {
                self?.errorHandler?("C'è stato un errore durante la fase di login. Riprova più tardi (Codice errore: -4)")
                return
            }
            userLogged = user
            completion?()
        }
    }
    
    func register(user: User, completion: (()->Void)? = nil) {
        let request = ToxNetworkRequest()
        request.requestType = "register_user"
        request.credentials = user
        
        guard let data = try? JSONEncoder().encode(request) else {
            self.errorHandler?("Errore mentre mi stavo preparando per comunicare con il server (Codice errore: -3)")
            return
        }
        
        executeNetworkRequest(withData: data) { [weak self] (response) in
            guard let user = response.user else {
                self?.errorHandler?("C'è stato un errore durante la fase di registrazione. Riprova più tardi (Codice errore: -5)")
                return
            }
            userLogged = user
            completion?()
        }
        
    }
    
}
