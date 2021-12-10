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
    @IBOutlet weak var temperatureSTRG: UILabel!
    @IBOutlet weak var feelTemp: UILabel!
    @IBOutlet weak var tempMini: UILabel!
    @IBOutlet weak var tempMaxi: UILabel!
    @IBOutlet weak var tempMinLocal: UILabel!
    @IBOutlet weak var tempMaxLocal: UILabel!
    
    @IBOutlet weak var cityNameOn: UILabel!
    
    @IBOutlet weak var cityNameOf: UILabel!
    
    
    let newYorkWeatherURL =  "https://api.openweathermap.org/data/2.5/weather?id=5128638&appid=a38ea3546e539b57468b3e6e31513ebc&units=metric&lang=fr"
    
    let STRGWeatherURL = "https://api.openweathermap.org/data/2.5/weather?q=Cambrai&appid=a38ea3546e539b57468b3e6e31513ebc&units=metric&lang=fr"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        date()
        makeAPICall()
    }
}


// MARK: - MANAGE API CALL

extension WeatherViewController {
    
    private func makeAPICall() {
        WeatherServices.shared.getWeather(urlString: newYorkWeatherURL) { (result) in
            switch result {
            case .some(let response):
                self.updateWeatherDisplayNYC(response: response)
            case .none :
                self.presentAlert()
            }
        }
        WeatherServices.shared.getWeather(urlString: STRGWeatherURL) { (result) in
            switch result {
            case .some(let response):
                self.updateWeatherDisplaySTRG(response: response)
            case .none:
                self.presentAlert()
            }
        }
    }
    
    private func updateWeatherDisplayNYC(response: WeatherResponse) {
        //self.cityNameOn.text = "\(String(response.main.cityName))"
        self.weatherDescriptionNY.text = response.weather[0].description.capitalizingFirstLetters()
        self.temperatureNYC.text = "\(Int(response.main.temperature.rounded()))°C"
        self.feelTemp.text = "\(Int(response.main.feelsLike.rounded()))°"
        self.tempMini.text = "\(Int(response.main.tempMin.rounded()))°"
        self.tempMaxi.text = "\(Int(response.main.tempMax.rounded()))°"
        
        if let data = try? Data(contentsOf: response.weather[0].weatherIconURL){
            self.weatherIcon.image = UIImage(data: data)
        }
    }
    
    private func updateWeatherDisplaySTRG(response: WeatherResponse) {
//        self.cityNameOf.text = "\(String(response.main.cityName))"
        self.weatherDescriptionLocal.text = response.weather[0].description.capitalizingFirstLetters()
        self.temperatureSTRG.text = "\(Int(response.main.temperature.rounded()))°C"
        self.tempMinLocal.text = "Min.\(Int(response.main.tempMin.rounded()))°"
        self.tempMaxLocal.text = "Max.\(Int(response.main.tempMax.rounded()))°"
        
        if let data = try? Data(contentsOf: response.weather[0].weatherIconURL){
            self.weatherCambraiIcon.image = UIImage(data: data)
        }
    }
    
}

// MARK: - PRESENTE ALERTS

extension WeatherViewController {
    
    private func presentAlert() {
        let alertVC = UIAlertController.init(title: "Une erreur est survenue", message: "erreur de chargement", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
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
        dateLabel.text = dateFormatter.string(from: date).capitalizingFirstLetters()
    }
    
}
extension String {
    func capitalizingFirstLetters() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    mutating func capitalizeFirstLetters() {
        self = self.capitalizingFirstLetters()
    }
}
