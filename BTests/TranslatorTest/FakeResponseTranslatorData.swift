//
//  FakeResponseConvertorData.swift
//  monPtiBaluchon
//
//  Created by Aurelien Waxin on 08/01/2022.
//

import Foundation

class FakeResponseTranslatorData {
    static let translatorUrl: URL = URL(string: "https://translation.googleapis.com/language/translate/v2?q=Bonjour&target=en&format=text&source=fr&model=base&key=AIzaSyAi6fT5IQzxHulPbYgymtY3azPw0TaSvGo")!
    static let responseOK = HTTPURLResponse(url: URL(string: "https://translation.googleapis.com/language/translate/v2?q=Bonjour&target=en&format=text&source=fr&model=base&key=AIzaSyAi6fT5IQzxHulPbYgymtY3azPw0TaSvGo")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyAi6fT5IQzxHulPbYgymtY3azPw0TaSvGo&target=en&source=fr&format=text")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class NetworkErrorTranslator: Error {}
    static let error = NetworkErrorTranslator()

    static var correctDataTranslator: Data {
        let bundle = Bundle(for: FakeResponseTranslatorData.self)
        let url = bundle.url(forResource: "DataTranslator", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let incorrectDataTranslator = "erreur".data(using: .utf8)!
}


