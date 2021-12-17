//
//  Weather.swift
//  B
//
//  Created by Aurélien Waxin on 03/12/2021.
//

import Foundation

struct WeatherResponse: Codable {
    
    let weather: [Weather]
    let main : Main
    
}

struct Weather: Codable {
    
    let description: String
    let icon: String
    
    var weatherIconURL: URL {
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        return URL(string: urlString)!
    }
    var weatherIconURL2: URL {
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        return URL(string: urlString)!
    }
}

struct Main: Codable {
   // let cityName: String
    let temperature: Double
    let tempMin: Double
    let tempMax: Double
    let feelsLike: Double
    let humidity: Int
    let pressure: Int
    
    enum CodingKeys: String, CodingKey {
       // case cityName = "name"
        case temperature = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case feelsLike = "feels_like"
        case humidity
        case pressure
    }
    
}



// MARK: - Format JSON

//{
//    "coord": {
//        "lon": 7.743,
//        "lat": 48.5834
//    },
//    "weather": [
//        {
//            "id": 804,
//            "main": "Clouds",
//            "description": "couvert",
//            "icon": "04d"
//        }
//    ],
//    "base": "stations",
//    "main": {
//        "temp": 22.33,
//        "feels_like": 22.19,
//        "temp_min": 21.27,
//        "temp_max": 23.58,
//        "pressure": 1018,
//        "humidity": 60
//    },
//    "visibility": 10000,
//    "wind": {
//        "speed": 2.57,
//        "deg": 180
//    },
//    "clouds": {
//        "all": 90
//    },
//    "dt": 1632756822,
//    "sys": {
//        "type": 1,
//        "id": 6595,
//        "country": "FR",
//        "sunrise": 1632720159,
//        "sunset": 1632763036
//    },
//    "timezone": 7200,
//    "id": 2973783,
//    "name": "Strasbourg",
//    "cod": 200
//}
