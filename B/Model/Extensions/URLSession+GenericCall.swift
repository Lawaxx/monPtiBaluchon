//
//  URLSession+GenericCall.swift
//  monPtiBaluchon
//
//  Created by Aurelien Waxin on 03/01/2022.
//

import Foundation

extension URLSession {

    // MARK: - Generic call

    func dataTask<T: Decodable>(with url: URL,
                                callback: @escaping (Result<T, APIError>) -> Void) {
        dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                callback(.failure(.dataError))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.serverResponseError))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(T.self, from: data) else {
                callback(.failure(.decodeError))
                return
            }
            callback(.success(dataDecoded))
        }.resume()
    }
}
