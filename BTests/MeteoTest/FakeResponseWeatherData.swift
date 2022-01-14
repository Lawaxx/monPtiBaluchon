//
//  FakeResponseWeatherData.swift
//  monPtiBaluchon
//
//  Created by Aurelien Waxin on 08/01/2022.
//

import Foundation

class FakeResponseWeatherData {
    static let weatherURL: URL = URL(string: "https://api.openweathermap.org/data/2.5/group?id=5128581,3029030&appid=a38ea3546e539b57468b3e6e31513ebc&units=metric&lang=fr")!
    static let responseOK = HTTPURLResponse(url: URL(string: "hhttps://api.openweathermap.org/data/2.5/group?id=5128581,3029030&appid=a38ea3546e539b57468b3e6e31513ebc&units=metric&lang=fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://api.openweathermap.org/data/2.5/group?id=5128581,3029030&appid=a38ea3546e539b57468b3e6e31513ebc&units=metric&lang=fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class NetworkErrorWeather: Error {}
    static let error = NetworkErrorWeather()

    static var correctDataWeather: Data {
        let bundle = Bundle(for: FakeResponseWeatherData.self)
        let url = bundle.url(forResource: "DataWeather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    static let incorrectDataWeather = "erreur".data(using: .utf8)!
}
