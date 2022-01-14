//
//  ViewController.swift
//  monPtiBaluchon
//
//  Created by Aurélien Waxin on 25/11/2021.
//

import Foundation

class ExchangeService {
    
    
    //MARK: - Properties
    
    private let session : URLSession
    private let exchangeUrl = "http://api.exchangeratesapi.io/v1/latest?access_key=\(APIKeys.fixerAPI)&format=1"
    
    
    
    //  MARK: - Initializer
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    //    MARK: - API Management
    
    func getExchange(callback: @escaping (Result<ExchangeResponse, APIError>) -> Void) {
        
        guard let url = URL(string: exchangeUrl) else {
            preconditionFailure("url must be valid")
        }
        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        session.dataTask(with: url, callback: callback)
    }
}

