//
//  Destination.swift
//  B
//
//  Created by Aurélien Waxin on 04/12/2021.
//

import Foundation

class Destination {
    
    // UIPIcker data source in Destination View Controller
    var options = ["NewYork", "Mexico", "London", "Moscow", "Beyrouth", "Tokyo", "Berlin"]
    // user selection is saved into UserDefaults to remain persistent
    var selection: String {
        get { UserDefaults.standard.string(forKey: "destination") ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: "destination") }
    }
    // returns the correct cityID parameter for OpenWeather request
    var cityId: String {
        switch selection {
        case "NewYork": return "5128638"
        case "Mexico": return "3530597"
        case "London": return "2643743"
        case "Moscow": return "524901"
        case "Beyrouth": return "276781"
        case "Tokyo": return "1850144"
        case "Berlin": return "2950159"
        default: return "5128638"
        } }
     // returns the correct symbol parameter for language output translation
    var outputLanguageSymbol: String {
        switch selection {
        case "NewYork": return "en"
        case "Mexico": return "es"
        case "London": return "en"
        case "Moscow": return "ru"
        case "Beyrouth": return "ar"
        case "Tokyo": return "ja"
        case "Berlin": return "de"
        default: return "en"
        }
    }
     // returns the associated language to be displayed on the translation UIButton
    var outputLanguage: String {
        switch selection {
        case "NewYork": return "English"
        case "Mexico": return "Spanish"
        case "London": return "English"
        case "Moscow": return "Russian"
        case "Beyrouth": return "Arabic"
        case "Tokyo": return "Japanese"
        case "Berlin": return "Deutch"
        default: return "English"
        }
    }
       // returns the associated language to be displayed on the translation UIButton
    var outputCurrency: String {
        switch selection  {
        case "NewYork": return "USD"
        case "Mexico": return "MXN"
        case "London": return "GBP"
        case "Moscow": return "RUB"
        case "Beyrouth": return "LBP"
        case "Tokyo": return "JPY"
        case "Berlin": return "EUR"
        default: return "USD"
        }
    }
       // returns the name of the associated image to display on the Destination View
    var imageId: String {
        switch selection  {
        case "NewYork": return "newyork"
        case "Mexico": return "mexico"
        case "London": return "london"
        case "Moscow": return "moscow"
        case "Beyrouth": return "beyrouth"
        case "Tokyo": return "tokyo"
        case "Berlin": return "berlin"
        default: return "USD"
        }
    }
}
