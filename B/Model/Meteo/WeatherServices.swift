//
//  File.swift
//  B
//
//  Created by Aurélien Waxin on 03/12/2021.
//

import Foundation

class WeatherServices {
    
    //    MARK: - Properties
    
    private let session : URLSession
    private let endpointURL = "https://api.openweathermap.org/data/2.5/group?id=5128581,3029030&appid=\(APIKeys.weatherAPI)&units=metric&lang=fr"
    
    //MARK: - Initializer
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    //    MARK: - API Management
    
    func getWeather(callback: @escaping (Result<WeatherResponse,APIError>) -> Void) {
        
        guard let url = URL(string: endpointURL) else { return }
        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        session.dataTask(with: url, callback: callback)
    }
}

