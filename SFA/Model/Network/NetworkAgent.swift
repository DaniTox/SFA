//
//  NetworkAgent.swift
//  SFA
//
//  Created by Dani Tox on 23/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation

class NetworkAgent<Response> where Response: ToxNetworkResponse & Codable {
    
    public var errorHandler : ((String) -> Void)?
    
    public func executeNetworkRequest<RequestType : ToxNetworkRequest> (with toxRequest: RequestType, responseCompletion: @escaping (Response)->Void)  {
        let pathComponent = toxRequest.requestType
        let urlString = "\(URLs.mainUrl)/\(pathComponent)"
        guard let url = URL(string: urlString) else {
            errorHandler?("Errore generico di quest'app (Codice: -1)")
            return
        }
        
//        guard let jsonData = try? JSONEncoder().encode(toxRequest) else {
//            errorHandler?("Errore mentre mi stavo preparando per comunicare con il server (Codice errore: -3)")
//            return
//        }
        
        let request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.httpBody = jsonData
        
        let session = URLSession.shared.dataTask(with: request) { (data, responseWeb, error) in
            if error != nil {
                self.errorHandler?("\(error!.localizedDescription)")
                return
            }
            
            guard let data = data else {
                self.errorHandler?("Il server ha risposto con un contenuto vuoto (Codice errore -2)")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                if response.code == "OK" {
                    responseCompletion(response)
                } else {
                    self.errorHandler?(response.message)
                    return
                }

            } catch {
                print(error)
                self.errorHandler?("\(error)")
                return
            }
        }
    
        session.resume()
        
    }
    
    
    
    
    
}
