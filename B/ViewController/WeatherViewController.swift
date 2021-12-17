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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Ciel.jpeg")!)
        date()
        makeAPICall()
    }
}


// MARK: - MANAGE API CALL

extension WeatherViewController {
    
    private func makeAPICall() {
        WeatherServices.shared.getWeatherNYC { (result) in
            switch result {
                case .success(let response):
                    self.updateWeatherDisplayNYC(response: response)
                case .failure:
                    self.presentAlert()
            }
        }
        WeatherServices.shared.getWeatherCBR { (result) in
            switch result {
            case .success(let response):
                self.updateWeatherDisplayCBR(response: response)
            case .failure:
                self.presentAlert()
            }
        }
    }
    
    private func updateWeatherDisplayNYC(response: WeatherResponse) {
        //self.cityNameOn.text = "\(String(response.main.cityName))"
        if let responseWeather = response.weather.first {
            weatherDescriptionNY.text = responseWeather.description.capitalizingFirstLetter()
        }
        temperatureNYC.text = "\(Int(response.main.temperature.rounded()))°C"
        feelTemp.text = "\(Int(response.main.feelsLike.rounded()))°"
        tempMini.text = "\(Int(response.main.tempMin.rounded()))°"
        tempMaxi.text = "\(Int(response.main.tempMax.rounded()))°"
        
        if let data = try? Data(contentsOf: response.weather[0].weatherIconURL){
            self.weatherIcon.image = UIImage(data: data)
        }
    }
    
    private func updateWeatherDisplayCBR(response: WeatherResponse) {
//        self.cityNameOf.text = "\(String(response.main.cityName))"
        if let responseWeather = response.weather.first {
            weatherDescriptionLocal.text = responseWeather.description.capitalizingFirstLetter()
        }
        temperatureCBR.text = "\(Int(response.main.temperature.rounded()))°C"
        tempMinLocal.text = "Min.\(Int(response.main.tempMin.rounded()))°"
        tempMaxLocal.text = "Max.\(Int(response.main.tempMax.rounded()))°"

        if let data = try? Data(contentsOf: response.weather[0].weatherIconURL2){
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
