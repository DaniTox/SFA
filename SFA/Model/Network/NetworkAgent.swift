//
//  NetworkAgent.swift
//  SFA
//
//  Created by Dani Tox on 23/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation

class NetworkAgent<Response: Decodable> {
    
    public var errorHandler : ((String) -> Void)?
    
    public func executeNetworkRequest<RequestType : ToxNetworkRequest> (with toxRequest: RequestType, responseCompletion: @escaping (Result<Response, Error>) -> Void)  {
        
        let pathComponent = toxRequest.requestType
        let urlString = "\(URLs.mainUrl)/\(pathComponent)"
        guard let url = URL(string: urlString) else {
            errorHandler?("Errore generico di quest'app (Codice: -1)")
            return
        }

        
        let request = URLRequest(url: url)

        let session = URLSession.shared.dataTask(with: request) { (data, responseWeb, error) in
            if error != nil {
                responseCompletion(.failure(error!))
                return
            }
            
            guard let data = data else {
                self.errorHandler?("Il server ha risposto con un contenuto vuoto (Codice errore -2)")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                responseCompletion(.success(response))
            } catch {
                responseCompletion(.failure(error))
            }
        }
    
        session.resume()
        
    }
    
    
    
    
    
}
