//
//  NetworkAgent.swift
//  SFA
//
//  Created by Dani Tox on 23/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation

class NetworkAgent {
    
    var errorHandler : ((String) -> Void)?
    
    private func executeNetworkRequest(withData jsonData: Data, responseCompletion: @escaping (ToxNetworkResponse)->Void)  {
        let urlString = URLs.mainUrl
        guard let url = URL(string: urlString) else {
            errorHandler?("Errore generico di quest'app (Codice: -1)")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData
        
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                self.errorHandler?("\(error!)")
                return
            }
            
            guard let data = data else {
                self.errorHandler?("Il server ha risposto con un contenuto vuoto (Codice errore -2)")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ToxNetworkResponse.self, from: data)
                if response.code == "OK" {
                    responseCompletion(response)
                } else {
                    self.errorHandler?(response.message)
                    return
                }

            } catch {
                self.errorHandler?("\(error)")
                return
            }
        }
    
        session.resume()
        
    }
    
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
