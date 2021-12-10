//
//  APIServices.swift
//  B
//
//  Created by Aurélien Waxin on 04/12/2021.
//

import Foundation

enum APIError: String, Error {
    
    case URLError = "there is a problem with the URL"
    case serverResponseError = "error server reponse"
    case decodeError = "Data can't be decoded !"
}

// This protocol will be used to implement all API services with a Generic network request function
protocol APIService {
    
    var session: URLSession { get }
    func request<T: Decodable>(baseUrl: String, parameters: [String: String], completion: @escaping((Result<T, APIError>) -> Void))
}

extension APIService {
    // This func will create the request with parameters and trigger the call() func
    func request<T: Decodable>(baseUrl: String, parameters: [String : String], completion: @escaping((Result<T, APIError>) -> Void)) {
        guard var components = URLComponents(string: baseUrl) else {
            return }
        components.setQueryItems(with: parameters)
        guard let url = components.url else {
            return }
        call(url: url, completion: completion)
    }
  // this func will make the network call, check the answer, and decode data
    func call<T: Decodable>(url: URL, completion: @escaping((Result<T, APIError>) -> Void)) {
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { // check data is not nil, and error is nil
                completion(.failure(.serverResponseError))
                return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { // check serverResponse status
                completion(.failure(.serverResponseError))
                return }
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else { // decode data
                completion(.failure(.decodeError))
                return }
            completion(.success(decodedData))
        }
        task.resume()
    }
}
