//
//  Translator.swift
//  B
//
//  Created by Aurélien Waxin on 05/12/2021.
//

import Foundation

struct TranslationResponse: Codable {
    struct Data: Codable {
        struct Translations: Codable {
            let translatedText: String
        }
        let translations: [Translations]
    }
    let data : Data
}

// MARK: - Json Response

//
//{
//    "data": {
//        "translations": [
//            {
//                "translatedText": "Les vies des Noirs comptent"
//            }
//        ]
//    }
//}
