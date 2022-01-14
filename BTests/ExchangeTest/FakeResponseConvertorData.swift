//
//  FakeResponseData.swift
//  monPtiBaluchon
//
//  Created by Aurelien Waxin on 06/01/2022.
//

import Foundation

class FakeResponseConvertorData { 
    static let exchangeUrl: URL = URL(string: "http://api.exchangeratesapi.io/v1/latest?access_key=7eee4c2071c648fa4467cb659bccf26a&format=1")!
    static let responseOK = HTTPURLResponse(url: URL(string: "http://api.exchangeratesapi.io/v1/latest?access_key=7eee4c2071c648fa4467cb659bccf26a&format=1")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http://api.exchangeratesapi.io/v1/latest?access_key=7eee4c2071c648fa4467cb659bccf26a&format=1")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class NetworkErrorConvertor: Error {}
    static let error = NetworkErrorConvertor()

    static var correctDataConvertor: Data {
        let bundle = Bundle(for: FakeResponseConvertorData.self)
        let url = bundle.url(forResource: "DataExchange", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let incorrectDataConvertor = "erreur".data(using: .utf8)!
}
