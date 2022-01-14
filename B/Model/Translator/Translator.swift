//
//  Translator.swift
//  B
//
//  Created by Aurélien Waxin on 05/12/2021.
//

import Foundation

// MARK: - Welcome
struct TranslationResponse: Decodable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Decodable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Decodable {
    let translatedText: String
}
// MARK: - Json Response

//
//{
//    "data": {
//        "translations": [
//            {
//                "translatedText": "Hello"
//            }
//        ]
//    }
//}
