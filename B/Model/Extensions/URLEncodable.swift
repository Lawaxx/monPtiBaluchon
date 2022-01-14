//
//  URLEncodable.swift
//  monPtiBaluchon
//
//  Created by Aurelien Waxin on 10/01/2022.
//

import Foundation

protocol URLEncodable {

    /// Encode a URL with a base URL and parameters
    func encode(with baseURL: URL, and parameters: [(String, Any)]?) -> URL
}

extension URLEncodable {
    func encode(with baseURL: URL, and parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false),
              let parameters = parameters,
              !parameters.isEmpty else {
            return baseURL
        }
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: "\($1)") }
        guard let url = urlComponents.url else { return baseURL }
        return url
    }
}
