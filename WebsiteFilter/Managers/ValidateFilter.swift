//
//  ValidateFilter.swift
//  WebsiteFilter
//
//  Created by Olya Sabadina on 2023-06-11.
//

import Foundation

struct ValidateFilter {
    
    public func isContainAtLeastTwoCharactersNoSpaces(text: String) -> Bool {
        let regularExpression = "^([a-zA-Z]{1,}[^ ])$"
        return NSPredicate(format: "SELF MATCHES %@", regularExpression).evaluate(with: text)
    }
}
