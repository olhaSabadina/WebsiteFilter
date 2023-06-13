//
//  EnumsTitles.swift
//  WebsiteFilter
//
//  Created by Olya Sabadina on 2023-06-12.
//

import UIKit

enum ElementsTitles {
    
    enum TitleViewControllers {
        static let webBrowserVC = "Website Filter"
        static let filterVC     = "Filter words"
    }
    
    enum AlertTitleAndMessage {
        static let notAllowedURTitle        = "Attention\nYou input Not Allowed URL."
        static let notAllowedURMessage      = "Please change your URL"
        static let addWordToFilterTitle     = "Exception"
        static let addWordToFilterMessage   = "Add a word to prevent opening links"
        static let filterRuleAlertTitle     = "Not valide filter word"
        static let filterRuleAlertMessage   = "You word mast have at least 2 characters and no spaces."
    }
    
    enum ActionPolicy {
        static let defaultURL = "https://www.google.com"
    }
    
    enum ImageForButtons {
        static let backBarImage = UIImage(systemName: "chevron.backward")
        static let backImage    = UIImage(named: "chevron.backward")
        static let forwardImage = UIImage(named: "chevron.right")
        static let refreshImage = UIImage(named: "arrow.clockwise")
        static let filterImage  = UIImage(named: "line.3.horizontal.decrease.circle")
        static let сlearImage   = UIImage(systemName: "xmark.circle.fill")
        static let googleImage  = UIImage(named: "icon-google")
        static let magnifyingglassImage  = UIImage(systemName: "magnifyingglass")
    }
}
