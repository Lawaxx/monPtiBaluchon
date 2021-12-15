//
//  ViewController.swift
//  monPtiBaluchon
//
//  Created by Aurélien Waxin on 25/11/2021.
//

import Foundation

class ExchangeService {
    
    static let shared = ExchangeService()
    
    private let exchangeUrl = "http://api.exchangeratesapi.io/v1/latest?access_key=7eee4c2071c648fa4467cb659bccf26a&format=1"
    
    
    private let session : URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getExchange(completion: @escaping (Result<ExchangeResponse, Error>) -> Void) {
        
        guard let url = URL(string: exchangeUrl) else {
            preconditionFailure("url must be valid")
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    return completion(.failure(error))
                }
                
                guard
                    let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) else {
                        return completion(.failure(APIError.serverResponseError))
                    }
                
                if let json = data {
                    do {
                        let ExchangeResponse = try JSONDecoder().decode(ExchangeResponse.self, from: json)
                        return completion(.success(ExchangeResponse))
                    } catch let error {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
}

