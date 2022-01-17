//
//  WeatherViewController.swift
//  B
//
//  Created by Aurélien Waxin on 03/12/2021.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherDescriptionNY: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherCambraiIcon: UIImageView!
    @IBOutlet weak var temperatureNYC: UILabel!
    @IBOutlet weak var weatherDescriptionLocal: UILabel!
    @IBOutlet weak var temperatureCBR: UILabel!
    @IBOutlet weak var feelTemp: UILabel!
    @IBOutlet weak var tempMini: UILabel!
    @IBOutlet weak var tempMaxi: UILabel!
    @IBOutlet weak var tempMinLocal: UILabel!
    @IBOutlet weak var tempMaxLocal: UILabel!
    
    @IBOutlet weak var cityNameOn: UILabel!
    
    @IBOutlet weak var cityNameOf: UILabel!
    
    let weatherServices = WeatherServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date()
        makeAPICall()
    }
}


// MARK: - MANAGE API CALL

extension WeatherViewController {
    
    private func makeAPICall() {
        
        weatherServices.getWeather { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self?.updateWeather(response: response)
                        self?.updateLocalWeather(response: response)
                    case .failure:
                        self?.presentAlert()
                }
            }
        }
    }
    
    private func updateWeather(response: WeatherResponse){
        if let responseWeather = response.list.first {
            weatherDescriptionNY.text = responseWeather.weather[0].weatherDescription.capitalizingFirstLetter()
        }
        temperatureNYC.text = "\(Int((response.list[0].main.temp.rounded())))°C"
        feelTemp.text = "\(Int(response.list[0].main.feelsLike.rounded()))°"
        tempMini.text = "\(Int(response.list[0].main.tempMin.rounded()))°"
        tempMaxi.text = "\(Int(response.list[0].main.tempMax.rounded()))°"
        
        if let data = try? Data(contentsOf: response.list[0].weather[0].weatherIconURL){
            self.weatherIcon.image = UIImage(data: data)
        }
    }
    
    private func updateLocalWeather(response: WeatherResponse){
        if let responseWeather = response.list.last {
            weatherDescriptionLocal.text = responseWeather.weather[0].weatherDescription.capitalizingFirstLetter()
        }
        temperatureCBR.text = "\(Int(response.list[1].main.temp.rounded()))°C"
        tempMinLocal.text = "Min.\(Int(response.list[1].main.tempMin.rounded()))°"
        tempMaxLocal.text = "Max.\(Int(response.list[1].main.tempMax.rounded()))°"
        
        if let data = try? Data(contentsOf: response.list[1].weather[0].weatherIconURL2){
            self.weatherCambraiIcon.image = UIImage(data: data)
        }
    }
}

// MARK: - MANAGE DATE
extension WeatherViewController {
    
    private func date() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateStyle = .full
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "EEEE d MMMM yyyy"
        dateLabel.text = dateFormatter.string(from: date).capitalizingFirstLetter()
    }
    
}
