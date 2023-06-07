//
//  UIButton+Extension.swift
//  WebsiteFilter
//
//  Created by Olya Sabadina on 2023-06-07.
//

import Foundation
import UIKit

extension UIButton {
    
    func buttonSettings(borderWidth: CGFloat, cornerRadius: CGFloat, borderColor: UIColor) {
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
    }
}

