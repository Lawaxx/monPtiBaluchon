//
//  FakeResponseData.swift
//  monPtiBaluchon
//
//  Created by Aurelien Waxin on 10/01/2022.
//

import Foundation

class FakeResponseData {
    static let exchangeUrl: URL = URL(string: "")!
    
    static let responseOK = HTTPURLResponse(url: URL(string: "")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class NetworkError: Error {}
    static let error = NetworkError()

    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let incorrectData = "erreur".data(using: .utf8)!
}
