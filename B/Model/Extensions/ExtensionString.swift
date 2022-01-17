//
//  ExtensionString.swift
//  B
//
//  Created by Aurélien Waxin on 03/12/2021.
//

import Foundation


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
