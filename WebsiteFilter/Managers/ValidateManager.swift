//
//  ValidateURL.swift
//  WebsiteFilter
//
//  Created by Olya Sabadina on 2023-06-07.
//

import Foundation

struct ValidateManager {
    
    func isValideLinkMask(text: String) -> Bool {
        let regularExpression =  "^(http[s]?:\\/\\/(www\\.)?|ftp:\\/\\/(www\\.)?|www\\.){1}([0-9A-Za-z-\\.@:%_\\+~#=]+)+((\\.[a-zA-Z]{2,3})+)(/(.)*)?(\\?(.)*)?"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: text)
    }
    
    func isContainsTwoCharactersNoSpaces(_ text: String) -> Bool {
        let regularExpression = "^([a-zA-Zа-яА-Я]{1,}[^ ])$"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: text)
    }
}

