//
//  UILabel+Extension.swift
//  RadioApp
//
//  Created by Елена Логинова on 05.08.2024.
//

import UIKit

extension UILabel {
    func textColorChange (fullText: String , changeText: String ) {
        let range = (fullText as NSString).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText); attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: range)
        self.attributedText = attribute }
}
