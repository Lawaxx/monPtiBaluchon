//
//  TranslatorServices.swift
//  B
//
//  Created by Aurélien Waxin on 05/12/2021.
//

import Foundation

class TranslateService : URLEncodable {
    
    
    //    MARK: - Properties
    private var session = URLSession(configuration: .default)
    
    
    //MARK: - Initializer
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    //MARK: - API Management
    
    func getTranslation(text: String, target: String, source: String ,callback: @escaping (Result<TranslationResponse,APIError>) -> Void){
        guard let baseURL = URL(string: "https://translation.googleapis.com/language/translate/v2") else { return }
        let parameters = [("q", text),("target",target),("format", "text"),("source",source),("model", "base"),("key", APIKeys.googleAPI)]
        let url = encode(with: baseURL, and: parameters)
        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        session.dataTask(with: url, callback: callback)
    }
}
