//
//  CustomFont.swift
//  RadioApp
//
//  Created by Елена Логинова on 29.07.2024.
//

import UIKit

enum CustomFont: String {
    case regular = "SFProDisplay-Regular"
    case medium = "SFProDisplay-Medium"
    case bold = "SFProDisplay-Bold"
}

extension UIFont {
    static func custom(font: CustomFont, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: font.rawValue, size: size) else {
          fatalError(
            "Failed to load the \(font.rawValue) font."
          )
        }
        return customFont
      }
}
