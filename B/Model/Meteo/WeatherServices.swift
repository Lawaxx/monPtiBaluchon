//
//  File.swift
//  B
//
//  Created by Aurélien Waxin on 03/12/2021.
//

import Foundation

class WeatherServices {
    
    static let shared = WeatherServices()
    
    private let endpointURLNYC =  "https://api.openweathermap.org/data/2.5/weather?id=5128638&appid=a38ea3546e539b57468b3e6e31513ebc&units=metric&lang=fr"
    
    private let endpointURLCBR = "https://api.openweathermap.org/data/2.5/weather?q=Cambrai&appid=a38ea3546e539b57468b3e6e31513ebc&units=metric&lang=fr"
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getWeatherNYC(completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        guard let url = URL(string: endpointURLNYC) else {
            preconditionFailure("url must be valid")
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    return completion(.failure(error))
                }
                
                guard
                    let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) else {
                        return completion(.failure(APIError.serverResponseError))
                    }
                
                if let json = data {
                    do {
                        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: json)
                        return completion(.success(weatherResponse))
                    } catch let error {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
    
    func getWeatherCBR(completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        guard let url = URL(string: endpointURLCBR) else {
            preconditionFailure("url must be valid")
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    return completion(.failure(error))
                }
                
                guard
                    let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) else {
                        return completion(.failure(APIError.serverResponseError))
                    }
                
                if let json = data {
                    do {
                        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: json)
                        return completion(.success(weatherResponse))
                    } catch let error {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
}

