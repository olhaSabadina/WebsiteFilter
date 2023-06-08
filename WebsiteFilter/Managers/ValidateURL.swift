//
//  ValidateURL.swift
//  WebsiteFilter
//
//  Created by Olya Sabadina on 2023-06-07.
//

import Foundation

struct ValidateManager {
    
    public func isValideLinkMask(text: String) -> Bool {
        var regularExpression = ""
        regularExpression = "^(http[s]?:\\/\\/(www\\.)?|ftp:\\/\\/(www\\.)?|www\\.){1}([0-9A-Za-z-\\.@:%_\\+~#=]+)+((\\.[a-zA-Z]{2,3})+)(/(.)*)?(\\?(.)*)?"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: text)
    }
}

