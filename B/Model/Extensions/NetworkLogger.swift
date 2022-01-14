//
//  NetworkLogger.swift
//  monPtiBaluchon
//
//  Created by Aurelien Waxin on 27/12/2021.
//

import Foundation

struct NetworkLogger {

    // MARK: - Properties

    var url: URL
    private var request: URLRequest {
        return URLRequest(url: url)
    }

    // MARK: - Class's Methods

    func show() {
        defer {
            print("\n *****************     End     ****************** \n")
        }

        guard let httpMethod = request.httpMethod else { return }
        guard let stringUrl = request.url?.absoluteString else { return }
        guard let urlComponents = NSURLComponents(string: stringUrl) else { return }
        guard let host = urlComponents.host else { return }
        guard let path = urlComponents.path else { return }
        let query = urlComponents.query ?? String()

        let logOutput = """
        ** HTTP Method : \(httpMethod)
        ** URL : \(stringUrl)
        ** Host : \(host)
        ** Path : \(path)
        ** Query : \(query)
        """

        print("\n ***************** Request info ***************** \n")
        print(logOutput)
    }
}
