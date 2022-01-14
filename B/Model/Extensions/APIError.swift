//
//  APIServices.swift
//  B
//
//  Created by Aurélien Waxin on 04/12/2021.
//

import Foundation

enum APIError: String, Error {
    
    case URLError = "there is a problem with the URL"
    case serverResponseError = "error server reponse"
    case decodeError = "Data can't be decoded !"
    case dataError = "The service is momentarily unavailable" 
}

